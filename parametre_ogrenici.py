from mitmproxy import http

def response(flow: http.HTTPFlow) -> None:
    content_length = flow.response.headers.get("Content-Length")
    if content_length == "0" or flow.response.status_code == 204: 
        soap_response = """
<soap-env:Envelope xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:soap-env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:cwmp="urn:dslforum-org:cwmp-1-0">
<soap-env:Header><cwmp:ID soap-env:mustUnderstand="1">2</cwmp:ID></soap-env:Header>
<soap-env:Body>
<cwmp:GetParameterValues><ParameterList soap-enc:arrayType="xsd:string[1]"><string>İSTEKDEKİİLKKOMUT</string></ParameterList>
</cwmp:GetParameterValues>
</soap-env:Body>
</soap-env:Envelope>
        """
        
        flow.response.status_code = 200
        flow.response.headers["Content-Length"] = str(len(soap_response.strip()))
        flow.response.text = soap_response.strip()
addons = [
    response
]
