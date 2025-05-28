#!/bin/bash

echo "🚀 Starting CryptPad Development Environment"
echo "=============================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Create config file if it doesn't exist
if [ ! -f "config.js" ]; then
    echo "📝 Creating development configuration..."
    cat > config.js << 'EOF'
module.exports = {
    httpUnsafeOrigin: 'http://localhost:2001',
    defaultStorageLimit: 500 * 1024 * 1024,
    verbose: true,
    maxUploadSize: 20 * 1024 * 1024,
    retentionTime: 30,
    archiveRetentionTime: 7,
    accountRetentionTime: 180,
};
EOF
fi

# Build and start
echo "🔨 Building Docker image..."
docker-compose build

echo "🏃 Starting CryptPad..."
docker-compose up -d

# Wait for startup
echo "⏳ Waiting for CryptPad to initialize..."
sleep 5

# Check if it's running
if curl -s http://localhost:2001 > /dev/null; then
    echo "✅ CryptPad is running!"
    echo "🌐 Access it at: http://localhost:2001"
    echo "📊 Create a spreadsheet: http://localhost:2001/sheet/#/2/sheet/edit/your-sheet-name/"
    echo "📝 View logs: docker-compose logs -f"
    echo "🛑 Stop: docker-compose down"
else
    echo "❌ CryptPad failed to start. Check logs with: docker-compose logs"
fi
