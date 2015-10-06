## What is skeletonkey?

Skeletonkey is a command line tool for storing and retrieving your passwords easily. The goals of the project are simplicity and security. It works using asymmetric encryption to securely lock your passwords in a safe that is only accessible by skeletonkey.

## Getting Started

### Installation

```
gem install skeletonkey
```

### Adding Passwords

Add a new password for an account or service, e.g., gmail, twitter, facebook, etc.
```
skeletonkey add gmail
```

Skeletonkey will then prompt you for a password. Don't have a password yet. Skeletonkey will generate one for you if you pass the generate option.
```
skeletonkey add --generate gmail
```

Passwords aren't very useful unless they can be retrieved easily. Get your password in plaintext:
```
skeletonkey get gmail
```

Alternatively, have it copied to your clipboard with the copy option.
```
skeletonkey get --copy gmail
```

Get a list of all your accounts stored in skeletonkey:
```
skeletonkey list
```

Remove an account by its key:
```
skeletonkey remove gmail
```

## Changelog

### 1.1.0
When adding a new key the password can be generated instead of entered manually

### 1.0.0
Add bash completion script
Make gem
Rename to skeletonkey

### 0.6.1
Users now get an error message instead of an exception when adding an empty password

### 0.6.0
Users now have to confirm their passwords before it will be put in the safe

### 0.5.0
Get command now accepts --copy flag for adding password to clipboard

### 0.4.0
Public and private keys as well as safe now stored in ~/.lockbox
Refactoring of object flow

### 0.3.0
Prevent passwords from displaying while using `./run.rb add KEY`

### 0.2.0
Add subcommand for listing all keys

### 0.1.0
Add label to password prompt
Add readme.md
