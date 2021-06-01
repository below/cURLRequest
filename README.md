# cURLRequest

This package adds a `curlCommand` extension to `URLRequest`, which should print an (escaped) cURL representation of your request to the terminal. It is mainly meant and useful for debugging

I have found some implementation on the web, but none as a SwiftPM module. Maybe I did not look hard enough, in the end I simply decided to re-invent the wheel myself.

The `curlCommand` supports:

* Headers
* JSON Encoded paylods
* URL Encoded paylods

I would be happy if this helps you in your project, and even happier if you have improvements
