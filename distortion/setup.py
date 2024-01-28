import sys
import subprocess

def install(packages):
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-r', packages])

