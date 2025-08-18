#!/bin/bash
set -e

# === Variables ===
KAFKA_VERSION="3.8.0"
SCALA_VERSION="2.13"
KAFKA_DIR="/opt/kafka"
SERVICE_DIR="$(pwd)"
KAFKA_USER="kafka"

# === Check & Install Java ===
if java -version &>/dev/null; then
    echo "✅ Java already installed"
else
    echo "=== Installing Java ==="
    sudo apt update
    sudo apt install -y openjdk-17-jdk wget
fi

# === Create Kafka user if missing ===
if id -u $KAFKA_USER >/dev/null 2>&1; then
    echo "✅ User '$KAFKA_USER' already exists"
else
    echo "=== Creating user '$KAFKA_USER' ==="
    sudo useradd -m -s /bin/bash $KAFKA_USER
fi

# === Check & Download Kafka ===
if [ -d "$KAFKA_DIR" ]; then
    echo "✅ Kafka already installed at $KAFKA_DIR"
else
    echo "=== Downloading Kafka ==="
    wget -q https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O /tmp/kafka.tgz
    echo "=== Extracting Kafka ==="
    sudo mkdir -p $KAFKA_DIR
    sudo tar -xzf /tmp/kafka.tgz -C /opt
    sudo mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/* $KAFKA_DIR
    sudo rm -rf /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /tmp/kafka.tgz
    sudo chown -R $KAFKA_USER:$KAFKA_USER $KAFKA_DIR
fi

# === Copy service files if not present ===
if [ -f "/etc/systemd/system/zookeeper.service" ]; then
    echo "✅ zookeeper.service already exists"
else
    sudo cp "$SERVICE_DIR/zookeeper.service" /etc/systemd/system/
fi

if [ -f "/etc/systemd/system/kafka.service" ]; then
    echo "✅ kafka.service already exists"
else
    sudo cp "$SERVICE_DIR/kafka.service" /etc/systemd/system/
fi

# === Reload systemd ===
echo "=== Reloading systemd ==="
sudo systemctl daemon-reload

# === Find server.properties from kafka.service file ===
KAFKA_CONFIG_FILE="/opt/kafka/config/server.properties"
echo "$KAFKA_CONFIG_FILE"
if [ -f "$KAFKA_CONFIG_FILE" ]; then
    echo "=== Updating Kafka port in $KAFKA_CONFIG_FILE ==="
    sudo sed -i 's/^#\?listeners=.*/listeners=PLAINTEXT:\/\/:9095/' "$KAFKA_CONFIG_FILE" # Update the port to 9095
else
    echo "❌ Could not find server.properties file!"
    exit 1
fi

# === Enable services ===
sudo systemctl enable zookeeper
sudo systemctl enable kafka

# === Start services ===
echo "=== Starting Zookeeper ==="
sudo systemctl start zookeeper
sleep 5

echo "=== Starting Kafka ==="
sudo systemctl start kafka

# === Check Status ===
sudo systemctl status zookeeper --no-pager
sudo systemctl status kafka --no-pager

# === Verify Kafka Port ===
if ss -tulnp | grep -q ":9095"; then
    echo "✅ Kafka is running on port 9095"
else
    echo "❌ Kafka is NOT running on port 9095"
fi

echo "=== Setup Complete ==="