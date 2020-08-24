[uri]::EscapeDataString("http://jamie clayton.com")


[uri]::EscapeUriString("https://jamie clayton secure.com")

# Test the code with variables
$applicationName = "http://Jamie Clayton Again.com"
$friendlyName = [uri]::EscapeUriString("$applicationName")
$friendlyName