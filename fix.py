import glob

for f in glob.glob('lib/games/*.dart'):
    with open(f, 'r', encoding='utf-8') as file:
        data = file.read()
    data = data.replace("\\'", "'")
    with open(f, 'w', encoding='utf-8') as file:
        file.write(data)
