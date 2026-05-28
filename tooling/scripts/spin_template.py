"""Run the repository cookiecutter template from a stable Poetry command."""

from __future__ import annotations

import argparse
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Sequence


def _repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def _parser(default_output_dir: Path) -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="spin_template",
        description=(
            "Crée un dépôt local CSS à partir du template cookiecutter "
            "du core Snowflake."
        ),
    )
    parser.add_argument(
        "-o",
        "--output-dir",
        default=str(default_output_dir),
        help=(
            "Dossier parent où créer le dépôt généré. "
            "Par défaut: le dossier parent du core Snowflake."
        ),
    )
    return parser


def _has_config_argument(cookiecutter_args: Sequence[str]) -> bool:
    config_arguments = ("--config-file", "--default-config")

    for argument in cookiecutter_args:
        if argument in config_arguments:
            return True
        if argument.startswith("--config-file="):
            return True

    return False


def main(argv: Sequence[str] | None = None) -> int:
    repo_root = _repo_root()
    template_dir = repo_root / "tooling" / "template"
    default_output_dir = repo_root.parent

    parser = _parser(default_output_dir)
    args, cookiecutter_args = parser.parse_known_args(argv)

    output_dir = Path(args.output_dir).expanduser().resolve()
    output_dir.mkdir(parents=True, exist_ok=True)

    if not template_dir.exists():
        print(f"Template introuvable: {template_dir}", file=sys.stderr)
        return 1

    print(f"Template: {template_dir}", flush=True)
    print(f"Sortie: {output_dir}", flush=True)

    with tempfile.TemporaryDirectory(prefix="spin-template-cookiecutter-") as config_dir:
        command = [
            sys.executable,
            "-m",
            "cookiecutter",
            "-o",
            str(output_dir),
        ]

        if not _has_config_argument(cookiecutter_args):
            config_path = Path(config_dir) / "config.yml"
            replay_dir = Path(config_dir) / "replay"
            config_path.write_text(f'replay_dir: "{replay_dir}"\n', encoding="utf-8")
            command.extend(["--config-file", str(config_path)])

        command.extend([str(template_dir), *cookiecutter_args])

        return subprocess.call(command)


if __name__ == "__main__":
    raise SystemExit(main())
