# FROM kalilinux/kali-rolling
FROM kalilinux/kali-rolling

# Prevent interactive prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install necessary packages
RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y ca-certificates && \
    echo "deb https://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://old.kali.org/kali sana main non-free contrib" >> /etc/apt/sources.list && \
    apt-get -yq install python3 host whois sslyze wapiti nmap dmitry dnsenum dnsmap dnsrecon dnswalk dirb \
    wafw00f whatweb nikto lbd xsser fierce theharvester davtest uniscan amass wget && \
    apt-get -yq autoremove && apt-get clean && rm -rf /var/lib/{apt,dpkg,cache,log}

# Add rapidscan.py script
ADD rapidscan.py /usr/local/bin/rapidscan.py

# Make sure rapidscan.py is executable
RUN chmod +x /usr/local/bin/rapidscan.py

# Set the working directory
WORKDIR /app

# Use Python 3 to execute the script
ENTRYPOINT ["python3", "/usr/local/bin/rapidscan.py"]
