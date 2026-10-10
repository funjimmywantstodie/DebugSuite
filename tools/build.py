from pathlib import Path
import subprocess


root = Path(__file__).resolve().parent.parent
source = root / "src" / "main.lua"
output = root / "dist" / "DebugSuite.lua"
output.parent.mkdir(parents=True, exist_ok=True)

subprocess.run(["darklua", "process", str(source), str(output)], cwd=root, check=True)
print(f"Built {output.relative_to(root)}")
