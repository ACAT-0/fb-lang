
alphabet_string = 'abcdefghijklmnopqrstuvwxyz '
alphabet = []

for i in alphabet_string:
    alphabet.append(i)

print(alphabet)
def loop():
    while True:
        text = input("Enter your text: ")
        print(f'your value is: {convert(text)}')

def startup():
    print("WELCOME TO THE CONVERTER")
    print("INPUT TEXT AND THE OUTPUT WILL BE A Fb VALUE")
    loop()

def convert(text):
    result = ''
    for letter in text:
        if letter in alphabet:
            converted = ''
            for i in range(alphabet.index(letter) + 1):
                converted = converted + '^'
            result = result + converted + '#>'
        else:
            print("error, your input was not a letter or a space")

    return result


startup()


