# funcryption

This is a console app written in Haskell for encrypting and decrypting text according to the following encryption algorithm:

> Take every 2nd character from the string, then the other characters, and concat them as a new string. Perform this the required number of times.

## Getting started

### Prerequisites

You need to have `stack` build tool installed on your computer to compile the project.

### Running the app

Clone the repository.

```bash
$ git clone https://github.com/gleb-dianov/funcryption.git
```

Compile the project.

```bash
$ cd funcryption
$ stack build
```

Run the project.

```bash
$ stack exec funcryption
```

## Examples

```bash
$ stack exec funcryption
Enter an action (Encrypt or Decrypt): hello?
Invalid action!
$ stack exec funcryption
Enter an action (Encrypt or Decrypt): Encrypt
Enter text: hello?
Enter how many times you want to run the algorithm: hello?
Invalid integer!
$ stack exec funcryption
Enter an action (Encrypt or Decrypt): Encrypt
Enter text: hello?
Enter how many times you want to run the algorithm: 91.7
Invalid integer!
$ stack exec funcryption
Enter an action (Encrypt or Decrypt): Encrypt
Enter text: This is a test!
Enter how many times you want to run the algorithm: 2
s eT ashi tist!
$ stack exec funcryption
Enter an action (Encrypt or Decrypt): Decrypt
Enter text: s eT ashi tist!
Enter how many times you want to run the algorithm: 2
This is a test!
```

## Running the tests

```bash
$ stack test
```
