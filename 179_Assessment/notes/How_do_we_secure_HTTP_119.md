# How do we secure HTTP?

## Secure HTTPS
Starts with `https://` instead of `http:/`.

With secure HTTP, every request and reponse is encrypted before it is sent. Transfer Layer Security (TLS) is used as the cryptographic protocol. Secure Sockets Layer (SSL) was used before TLS.

## Same-origin policy
This allows documents/files/scripts to be accessed on the same site but prevents those from other sites. Documents from the same origin have the same **protocol**, **hostname**, and **port number**. 

This of course poses a problem if a website has Cross-origin resource sharing (CORS)