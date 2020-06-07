
-- this function will be executed first
function checkRAW()
	--[[ Following functions can be used:
		HEP.applyHeader(header string, value string)
		HEP.setCustomHeaders(m *map[string]string)
		HEP.getSIPObject()
		HEP.getHEPProtoType()
		HEP.getHEPSrcIP()
		HEP.getHEPSrcPort()
		HEP.getHEPDstIP()
		HEP.getHEPDstPort()
		HEP.getHEPTimeSeconds()
		HEP.getHEPTimeUseconds()
		HEP.getHEPObject()
		HEP.getRawMessage()
		HEP.logData(level string, message string, data interface{})
		HEP.print(text string)
	--]]
	
	local protoType = HEP.getHEPProtoType()

	-- Check if we have SIP type 
	if protoType ~= 1 then
		return
	end

	-- original SIP message Payload
	local raw = HEP.getRawMessage()
	-- HEP.logData("DEBUG", "raw", raw)

	-- Create lua table 
	local headers = {}
	headers["X-test"] = "Super TEST Header"

	-- local _, _, name, value = string.find(raw, "(Call-ID:)%s*:%s*(.+)")
	local name, value = raw:match("(CSeq):%s+(.-)\n")

	if name == "CSeq" then
		headers[name] = value
	end


	HEP.setCustomHeaders(headers)
	
	--[[ Following header can be changed with applyHeader func:
		"Via"
		"FromUser"
		"FromHost"
		"FromTag"
		"ToUser"
		"ToHost"
		"ToTag"
		"Call-ID"
		"X-CID"
		"ContactUser"
		"ContactHost"
		"User-Agent"
		"Server"
		"AuthorizationUsername"
		"Proxy-AuthorizationUsername"
		"PAIUser"
		"PAIHost"
		"RAW"
	--]]

	-- HEP.applyHeader("User-Agent", "FritzBox")

	-- Full SIP messsage can be changed with the "RAW" header
	-- HEP.applyHeader("RAW", "SIP 2/0")

	return 

end

-- this function will be executed second
function checkSIP()
	-- get the parsed SIP object
	local sip = HEP.getSIPObject()

	if sip.FromHost == "127.0.0.1" then
		-- HEP.logData("ERROR", "sip", sip)
		print(sip.Msg)
	end

	return 

end