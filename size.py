import sys
import os

def main():
    fname = sys.argv[1]
    
    if not os.path.isfile(fname):
        print('File does not exist.')
        sys.exit()

    # Check how many bytes from the file are not zero
    with open(fname, 'rb') as f:
        f.seek(0, os.SEEK_SET)
        data = f.read()
        count = 0
        for byte in data:
            if byte != 0:
                count += 1

    print('Used bytes: {}/{}'.format(count, len(data)))


if __name__ == '__main__':
    main()
