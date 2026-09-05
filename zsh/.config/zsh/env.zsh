export PYTHONSTARTUP="$HOME/.config/pythonrc.py"

### Spring-specific

# export ANTHROPIC_BASE_URL=http://127.0.0.1:8787 claude
export CAVE_GATEWAY_URL="http://127.0.0.1:8788"

if [[ $(uname) == "Darwin" ]]; then
	export SSL_CERT_FILE=~/corp-ca-bundle.pem
	export REQUESTS_CA_BUNDLE=~/corp-ca-bundle.pem
	export CURL_CA_BUNDLE=~/Documents/corp-ca-bundle.pem
	export OP_BIOMETRIC_UNLOCK_ENABLED=true
	export OP_ACCOUNT=springhealth.1password.com
	export AGENTOS_TELEMETRY_DISABLED=1
	export SPRING_DIRECTORY=/Users/sam.raymer/src/spring
fi

