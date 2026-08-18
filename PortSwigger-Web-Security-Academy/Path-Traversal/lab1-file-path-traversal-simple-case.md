# Lab: File Path Traversal, Simple Case

**Platform:** PortSwigger Web Security Academy  
**Topic:** Path Traversal  
**Difficulty:** Apprentice  
**Status:** Solved

## Objective
Retrieve the contents of `/etc/passwd` by exploiting a path traversal 
vulnerability in a shopping application's image-loading functionality.

## Approach
1. Identified the vulnerable endpoint by inspecting a product image URL:
   `/image?filename=75.jpg`
2. Modified the `filename` parameter to traverse up the directory structure 
   and target the system's password file:
   `/image?filename=../../../etc/passwd`
3. Used `view-source:` prefix in the browser to render the raw response as 
   text instead of attempting to display it as an image.

## Result
Successfully retrieved the full contents of `/etc/passwd`, confirming the 
application does not validate or sanitize the `filename` parameter before 
using it to read files from disk.

## Key Takeaway
Applications that build file paths from unsanitized user input are vulnerable 
to path traversal. The fix is to validate/sanitize input (e.g., strip `../` 
sequences, use an allow-list of permitted filenames) rather than trusting 
the client-supplied path directly.
