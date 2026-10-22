from pathlib import Path
import argparse
import os
import shutil
import subprocess


# Optional: paste your executor workspace path here to copy each build there.
# Example: WORKSPACE = r"C:\Users\maxim\AppData\Local\Volt\workspace"
WORKSPACE = r"C:\Users\maxim\AppData\Local\Volt\workspace"

root = Path(__file__).resolve().parent.parent
parser = argparse.ArgumentParser(description="Build DebugSuite and optionally copy it to the configured workspace.")
parser.add_argument("--no-copy", action="store_true", help="Build locally without copying to the executor workspace")
args = parser.parse_args()
source = root / "src" / "main.lua"
output = root / "dist" / "DebugSuite.lua"
output.parent.mkdir(parents=True, exist_ok=True)

subprocess.run([os.environ.get("DARKLUA", "darklua"), "process", str(source), str(output)], cwd=root, check=True)
print(f"Built {output.relative_to(root)}")

bootstrapper = root / "tools" / "Bootstrap.lua"
bootstrapper.write_text(
    'local run, err = loadfile("DebugSuite.lua")\n'
    'assert(run, err)\n'
    'return run()\n',
    encoding="utf-8",
)

if WORKSPACE and not args.no_copy:
    workspace = Path(WORKSPACE).expanduser().resolve()
    workspace.mkdir(parents=True, exist_ok=True)
    destination = workspace / output.name
    if destination != output.resolve():
        shutil.copy2(output, destination)
    print(f"Copied DebugSuite.lua to {workspace}")
