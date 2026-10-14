from pathlib import Path
import os
import shutil
import subprocess


root = Path(__file__).resolve().parent.parent

# Read the optional local workspace setting; shell variables take precedence.
workspace_setting = ""
env_file = root / ".env"
if env_file.is_file():
    for line in env_file.read_text(encoding="utf-8").splitlines():
        key, separator, value = line.strip().partition("=")
        if separator and key.strip() == "DEBUGSUITE_WORKSPACE":
            workspace_setting = value.strip()
            if (
                len(workspace_setting) >= 2
                and workspace_setting[0] in ("'", '"')
                and workspace_setting[-1] == workspace_setting[0]
            ):
                workspace_setting = workspace_setting[1:-1]

WORKSPACE = os.environ.get("DEBUGSUITE_WORKSPACE", workspace_setting)

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
