from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parent.parent
with tempfile.TemporaryDirectory() as temp:
    bundle = Path(temp) / 'bundle.luau'
    test = Path(temp) / 'smoke.luau'
    subprocess.run(['darklua', 'process', 'tests/Smoke.lua', str(bundle)], cwd=root, check=True)
    test.write_text((root / 'tests/mock.luau').read_text() + '\n' + bundle.read_text())
    subprocess.run(['luau', str(test)], cwd=root, check=True)

    subprocess.run(['darklua', 'process', 'src/Test.lua', str(bundle)], cwd=root, check=True)
    test.write_text((root / 'tests/mock.luau').read_text() + '\n' + bundle.read_text() + '\nwindow:Destroy()\nassert(connections == 0)\nprint("demo passed")\n')
    subprocess.run(['luau', str(test)], cwd=root, check=True)
