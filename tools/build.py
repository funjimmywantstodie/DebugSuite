from pathlib import Path
import shutil
import subprocess


# optionaly, paste your executor workspace path here to copy each build there.
WORKSPACE = r"C:\Users\funjimmy\AppData\Local\Volt\workspace"

root = Path(__file__).resolve().parent.parent
source = root / "src" / "main.lua"
output = root / "dist" / "DebugSuite.lua"
output.parent.mkdir(parents=True, exist_ok=True)

subprocess.run(["darklua", "process", str(source), str(output)], cwd=root, check=True)
print(f"Built {output.relative_to(root)}")

bootstrapper = root / "tools" / "Bootstrap.lua"
bootstrapper.write_text(
    'local run, err = loadfile("DebugSuite.lua")\n'
    'assert(run, err)\n'
    'return run()\n',
    encoding="utf-8",
)

if WORKSPACE:
    workspace = Path(WORKSPACE).expanduser().resolve()
    workspace.mkdir(parents=True, exist_ok=True)
    destination = workspace / output.name
    if destination != output.resolve():
        shutil.copy2(output, destination)
    print(f"Copied DebugSuite.lua to {workspace}")
