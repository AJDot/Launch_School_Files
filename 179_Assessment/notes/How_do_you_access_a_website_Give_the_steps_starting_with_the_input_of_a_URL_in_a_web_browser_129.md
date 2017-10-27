# How do you access a website? Give the steps starting with the input of a URL in a web browser.

1. Input a URL into a browser
2. URL is sent to the ISP (Internet Service Provider)
3. The ISP looks for the IP address associated with the URL. The ISP requests the information from a Domain Name Server (DNS).
4. The DNS finds the address and returns it to the ISP.
5. The ISP then sends the request to the known IP address.
6. The request may be sent through multiple paths and numerous routers but all packets eventually reach the server (if successful).
7. Server processes request and sends a response.
8. It is the job of the Transmission Control Protocol (TCP) to verify all information trying to be sent was completed successfully.
9. Then the client (usually a browser) can process the response and display a webpage, request other resources, etc.