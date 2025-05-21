
# 🏛️ Caesar Cipher in x86 Assembly

A simple, interactive Caesar Cipher implementation written in x86 Assembly (NASM/GAS syntax).  
Encrypts any alphabetic text using a user-supplied shift, preserving case and skipping non-letters.

---

## ✨ Features

- **User-friendly prompts** for plaintext and shift value
- **Handles both uppercase and lowercase** letters
- **Wraps around alphabet** (e.g., 'Z' + 1 → 'A')
- **Skips non-alphabetic characters**
- **Efficient, low-level implementation**

---

## 🚀 How It Works

1. **Prompt for plaintext**  
   User is asked to enter the text to encrypt.

2. **Prompt for shift value**  
   User enters a number (e.g., 3 for the classic Caesar cipher).

3. **Encryption**  
   Each letter is shifted by the given value, wrapping around A-Z or a-z.

4. **Output**  
   The encrypted text (ciphertext) is displayed.

---

## 🛠️ Step-by-Step Usage

### 1️⃣ Assemble and Link

```


# Assemble

nasm -f elf32 ceaser.asm -o ceaser.o

# Link

ld -m elf_i386 ceaser.o -o ceaser

```

### 2️⃣ Run the Program

```

./ceaser

```

### 3️⃣ Example Session

```

Please enter the plaintext: Hello, World!
Please enter the shift value: 3

Khoor, Zruog!

```

---

## 🧩 How the Code Works (Visual Guide)

```

flowchart TD
A[Start] --> B[Prompt for plaintext]
B --> C[Read plaintext into buffer]
C --> D[Prompt for shift value]
D --> E[Read shift value as string]
E --> F[Convert shift string to integer]
F --> G[Apply Caesar cipher to buffer]
G --> H[Calculate ciphertext length]
H --> I[Print ciphertext]
I --> J[Exit]

```

---

## 💡 Key Functions

- **PrintFunction**: Outputs strings to the terminal
- **ReadFromStdin**: Reads user input
- **GetStringLength**: Finds string length up to newline
- **AtoI**: Converts ASCII string to integer
- **CaesarCipher**: Applies the shift to each letter

---

## 📝 Caesar Cipher Logic

- For each character:
    - **If uppercase**: Shift within 'A'-'Z'
    - **If lowercase**: Shift within 'a'-'z'
    - **Else**: Leave unchanged

---

## 📦 File Structure

```

ceaser.asm      \# Main assembly source

```

---

## 🧠 Notes

- Only **alphabetic characters** are shifted. Punctuation, numbers, and spaces are unchanged.
- Shift value can be any integer between 0 and 255 (only the modulo 26 part is used for letters).
- Input is limited to 101 characters for plaintext and 3 digits for the shift value.

---

## 🏁 Exit

The program prints the encrypted message and exits cleanly.

---

## 👩‍💻 Authors

- Kurudunje Deekshith Shetty

---

## 📚 References

- [Wikipedia: Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher)
- [x86 Assembly Language Reference](https://www.felixcloutier.com/x86/)

---

Enjoy encrypting your messages the ancient Roman way! 🏺🔒


