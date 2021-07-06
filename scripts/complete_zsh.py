import os
import sys

DIR = sys.argv[1]
COMMANDS_PATH = "{}/commands".format(DIR)

options = ['help', 'verbose', 'source', 'region', 'profile']
joined_options = " ".join([f'"--{o}"' for o in options])
commands = sorted(os.listdir(COMMANDS_PATH))
print('''
function _awsinfo_zsh {
  # setopt local_options xtrace
  local line
  ''')
print("  _arguments " + joined_options + f' "1: :({" ".join(commands)})" "*::arg:->args"')
print('''
case $line[1] in''')

for command in commands:
    subfiles = os.listdir('{}/{}'.format(COMMANDS_PATH, command))
    subcommands = (' '.join([s.split('.')[0] for s in subfiles if s.endswith('.bash') and s != 'index.bash']))
    if subcommands:
        print('    {}) _arguments {} "1: :({})";;'.format(command, joined_options, subcommands))
print("esac")
print("}")

print('compdef _awsinfo_zsh awsinfo')
