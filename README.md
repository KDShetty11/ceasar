# Caesar Cipher in x86 Assembly

A simple, interactive Caesar Cipher implementation written in x86 Assembly (NASM syntax).
Encrypts alphabetic text using a user-supplied shift value, preserving case and skipping non-letter characters.

---

## Features

- User prompts for plaintext and shift value
- Handles both uppercase and lowercase letters
- Wraps around the alphabet (e.g., 'Z' + 1 = 'A')
- Skips non-alphabetic characters (spaces, punctuation, numbers)
- Pure assembly — no C library dependencies

---

## How It Works

1. **Prompt for plaintext** — user enters the text to encrypt
2. **Prompt for shift value** — user enters a number (e.g., 3 for classic Caesar)
3. **Encryption** — each letter is shifted, wrapping around A-Z or a-z
4. **Output** — the ciphertext is displayed

---

## Usage

### Assemble and Link

```bash
nasm -f elf32 ceasar.s -o ceasar.o
ld -m elf_i386 ceasar.o -o ceasar
```

### Run

```bash
./ceasar
```

### Example

```
Please enter the plaintext: Hello, World!
Please enter the shift value: 3

Khoor, Zruog!
```

---

## Code Structure

```
ceasar.s             # Main assembly source
caesar-template.s    # Template/reference version
```

### Key Functions

| Function | Purpose |
| :-- | :-- |
| `PrintFunction` | Outputs strings to terminal via `sys_write` |
| `ReadFromStdin` | Reads user input via `sys_read` |
| `GetStringLength` | Finds string length up to newline |
| `AtoI` | Converts ASCII string to integer |
| `CaesarCipher` | Applies the shift to each letter |

### Cipher Logic

- **Uppercase (A-Z):** Shift within ASCII 65-90, wrap with modulo
- **Lowercase (a-z):** Shift within ASCII 97-122, wrap with modulo
- **Other characters:** Pass through unchanged

---

## Notes

- Shift value can be 0-255 (only modulo 26 is applied to letters)
- Input buffer limited to 101 characters for plaintext, 3 digits for shift

---

## Author

**Kurudunje Deekshith Shetty**

---

## References

- [Wikipedia: Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher)
- [x86 Assembly Language Reference](https://www.felixcloutier.com/x86/)
