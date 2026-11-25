from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class ShellEnvironmentTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="shell environment ")
        self.addCleanup(self.temp.cleanup)
        self.home = Path(self.temp.name)
        for package in ("bash", "zsh", "shell"):
            shutil.copytree(ROOT / package, self.home, dirs_exist_ok=True)
        for directory in ("bin", ".local/bin", ".dotnet", ".dotnet/tools"):
            (self.home / directory).mkdir(parents=True, exist_ok=True)
        dotnet = self.home / ".dotnet/dotnet"
        dotnet.write_text("#!/bin/sh\nprintf 'fixture SDK\\n'\n")
        dotnet.chmod(0o755)
        self.env = {
            "HOME": str(self.home),
            "PATH": "/usr/bin:/bin",
            "BASH_ENV": str(self.home / ".config/bash/env.bash"),
            "ZDOTDIR": str(self.home),
        }

    def run_shell(self, shell, command, *args):
        return subprocess.run(
            [shell, *args, "-c", command],
            env=self.env,
            text=True,
            capture_output=True,
            check=True,
        ).stdout.strip()

    def test_sdk_discovery_through_real_noninteractive_startup(self):
        for shell in ("/bin/bash", "/bin/zsh"):
            with self.subTest(shell=shell):
                result = self.run_shell(shell, "command -v dotnet; dotnet")
                self.assertEqual(
                    result.splitlines(),
                    [str(self.home / ".dotnet/dotnet"), "fixture SDK"],
                )

    def test_bash_login_startup(self):
        result = self.run_shell(
            "/bin/bash", "command -v dotnet; dotnet", "--login"
        )
        self.assertEqual(
            result.splitlines()[-2:],
            [str(self.home / ".dotnet/dotnet"), "fixture SDK"],
        )

    def test_startup_exports_bash_env_for_command_runners(self):
        self.env.pop("BASH_ENV")
        for shell, args in (("/bin/bash", ("--login",)), ("/bin/zsh", ())):
            with self.subTest(shell=shell):
                result = self.run_shell(
                    shell,
                    '[[ $BASH_ENV == "$HOME/.config/bash/env.bash" ]] || exit 1; '
                    "/bin/bash --noprofile --norc -c "
                    "'type path_back >/dev/null; command -v dotnet'",
                    *args,
                )
                self.assertEqual(
                    result.splitlines()[-1], str(self.home / ".dotnet/dotnet")
                )

    def test_shared_ordering_missing_directories_and_idempotency(self):
        shutil.rmtree(self.home / ".dotnet")
        for shell in ("/bin/bash", "/bin/zsh"):
            with self.subTest(shell=shell):
                result = self.run_shell(
                    shell,
                    'before=$PATH; . "$HOME/.config/shell/env.sh"; '
                    '[[ $before == "$PATH" ]] || exit 1; printf "%s" "$PATH"',
                ).split(":")
                self.assertNotIn(str(self.home / ".dotnet"), result)
                self.assertNotIn(str(self.home / ".dotnet/tools"), result)
                self.assertLess(result.index("/usr/bin"), result.index("/bin"))
                self.assertLess(
                    result.index(str(self.home / "bin")),
                    result.index(str(self.home / ".local/bin")),
                )
                self.assertEqual(len(result), len(set(result)))

    def test_path_editors_preserve_literal_arguments_and_order(self):
        first = self.home / "first [x].*"
        second = self.home / "second"
        first.mkdir()
        second.mkdir()
        self.env.update(FIRST=str(first), SECOND=str(second))
        for shell in ("/bin/bash", "/bin/zsh"):
            with self.subTest(shell=shell):
                result = self.run_shell(
                    shell,
                    'PATH="/bin:$FIRST:/usr/bin:$FIRST"; '
                    'path_front "$FIRST" "$SECOND" "$FIRST"; '
                    'printf "%s\\n" "$PATH"; '
                    'path_back "$FIRST" "$SECOND" "$FIRST"; '
                    'printf "%s\\n" "$PATH"; '
                    'path_back "$HOME/missing"; printf "%s" "$PATH"',
                ).splitlines()
                self.assertEqual(result[0], f"{first}:{second}:/bin:/usr/bin")
                self.assertEqual(result[1], f"/bin:/usr/bin:{first}:{second}")
                self.assertEqual(result[2], result[1])

    def test_empty_path_and_missing_entries(self):
        for shell in ("/bin/bash", "/bin/zsh"):
            with self.subTest(shell=shell):
                result = self.run_shell(
                    shell,
                    'PATH=":$HOME/missing::"; path_back "$HOME/missing"; '
                    '[[ -z $PATH ]] || exit 1; '
                    'path_front "$HOME/bin"; printf "%s" "$PATH"',
                )
                self.assertEqual(result, str(self.home / "bin"))

    def test_zsh_native_array_stays_unique_and_linked(self):
        result = self.run_shell(
            "/bin/zsh",
            'path=("$HOME/bin" $path); path+=("$HOME/bin"); '
            '[[ ${path[1]} == "$HOME/bin" ]] || exit 1; printf "%s" "$PATH"',
        ).split(":")
        self.assertEqual(result.count(str(self.home / "bin")), 1)

    def test_local_hooks_and_rust_environment(self):
        hooks = {
            ".cargo/env": 'path_front "$HOME/.cargo/bin"\n',
            ".local/share/shell/env.sh": "export SHARED_HOOK=shared\n",
            ".local/share/bash/env.bash": "export SHELL_HOOK=bash\n",
            ".local/share/zsh/env.zsh": "export SHELL_HOOK=zsh\n",
        }
        (self.home / ".cargo/bin").mkdir(parents=True)
        for name, content in hooks.items():
            target = self.home / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(content)
        for shell in ("/bin/bash", "/bin/zsh"):
            with self.subTest(shell=shell):
                result = self.run_shell(
                    shell,
                    'printf "%s\\n" "$SHARED_HOOK:$SHELL_HOOK" "${PATH%%:*}"',
                ).splitlines()
                self.assertEqual(result[0], f"shared:{Path(shell).name}")
                self.assertEqual(result[1], str(self.home / ".cargo/bin"))

    def test_noninteractive_startup_uses_no_external_commands(self):
        for shell in ("/bin/bash", "/bin/zsh"):
            with self.subTest(shell=shell):
                result = subprocess.run(
                    [shell, "-x", "-c", ":"],
                    env=self.env,
                    text=True,
                    capture_output=True,
                    check=True,
                )
                for external in ("sed", "tr", "head", "compgen", "brew", "fnm"):
                    self.assertNotRegex(
                        result.stderr, rf"(?m)^\++(?:[^>]*> )?{external} "
                    )


if __name__ == "__main__":
    unittest.main()
