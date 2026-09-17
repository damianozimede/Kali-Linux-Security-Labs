import os
import ast
import html

# FIX (CWE-78): OS Command Injection - removed os.system() call, replaced with allow-list
user_input = input("Enter a command: ").strip().lower()
allowed_commands = {
    "status": "status"
}
if user_input in allowed_commands:
    print("Command status requested.")
else:
    print("Command not allowed.")


# FIX (CWE-311): Missing Encryption of Sensitive Data - encrypt before writing to disk
try:
    from cryptography.fernet import Fernet

    key = os.environ.get('ENCRYPTION_KEY', Fernet.generate_key())
    cipher = Fernet(key)

    encrypted_data = cipher.encrypt('Secret Data'.encode())
    with open('sensitive_data.txt', 'wb') as file:
        file.write(encrypted_data)
except ImportError:
    print("cryptography library not installed - encryption step skipped.")


# FIX (CWE-190): Integer Overflow - validate input range before arithmetic
MAX_NUMBER = 1_000_000
MAX_RESULT = 10**18

def calculate(data):
    multiplier = 1_000_000
    result = data * multiplier
    if abs(result) > MAX_RESULT:
        raise ValueError("Result is too large.")
    print(result)

try:
    data = int(input("Enter a number: "))
    if abs(data) > MAX_NUMBER:
        raise ValueError("Number is outside the allowed range.")
    calculate(data)
except ValueError as e:
    print(f"Invalid input: {e}")


# FIX (CWE-120): Buffer Overflow - enforce length check before writing into fixed buffer
buffer = bytearray(10)
data = input("Enter more than 10 characters: ")
encoded_data = data.encode("utf-8")
if len(encoded_data) > len(buffer):
    print("Input exceeds the 10-byte buffer limit.")
else:
    buffer[:len(encoded_data)] = encoded_data


# FIX (CWE-807 / CWE-306): Reliance on Untrusted Input / Missing Authentication
def admin_action():
    print("Performing an admin action")

action = input("Action (admin or user): ").strip().lower()
is_authenticated_admin = False  # would be set only after a real login check

if action == "admin" and is_authenticated_admin:
    admin_action()
elif action == "admin":
    print("Access denied.")


# FIX (CWE-798): Hard-coded Credentials - moved to environment variables
admin_username = os.environ.get("ADMIN_USERNAME", "")
admin_password = os.environ.get("ADMIN_PASSWORD", "")


# FIX (CWE-676): Use of a Potentially Dangerous Function - replaced exec() with allow-list dispatch
external_func = input("Enter the function to call: ").strip()
allowed_functions = {
    "admin_action": admin_action
}
if external_func in allowed_functions:
    allowed_functions[external_func]()
else:
    print("Function not allowed.")


# FIX (CWE-79): Cross-Site Scripting - escape output before embedding in HTML
user_input = input("Enter your name: ")
safe_input = html.escape(user_input)
print(f"<h1>Hello, {safe_input}</h1>")


# FIX (CWE-494): Download of Code Without Integrity Check
# Executing remote code without verification removed entirely - no trusted
# checksum/signature source was provided for this script, and HTTP (not HTTPS)
# offers no protection against tampering in transit.
print("Remote code execution disabled: no integrity verification available.")


# FIX (CWE-676): Use of a Potentially Dangerous Function - replaced eval() with ast.literal_eval()
user_input = input("Enter Python code to execute: ")
try:
    result = ast.literal_eval(user_input)
    print(result)
except (ValueError, SyntaxError):
    print("Invalid or disallowed input.")
# Alternative (more conservative) fix: disable the feature entirely
# print("Dynamic code execution is disabled for security.")
