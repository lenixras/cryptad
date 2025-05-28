// config.js - Configuration pour développement
module.exports = {
    // Domain configuration for development
    httpUnsafeOrigin: 'http://localhost:2001',
    
    // Increase storage limit for development (500MB instead of 50MB)
    defaultStorageLimit: 500 * 1024 * 1024,
    
    // Enable more verbose logging in development
    verbose: true,
    
    // Disable some production-only features
    adminEmail: false,
    supportMailbox: false,
    
    // Allow file uploads up to 20MB
    maxUploadSize: 20 * 1024 * 1024,
    
    // Retention settings (shorter for development)
    retentionTime: 30, // 30 days instead of 90
    archiveRetentionTime: 7, // 7 days instead of 15
    accountRetentionTime: 180, // 180 days instead of 365
    
    // Development-friendly settings
    filePath: './datastore/',
    archivePath: './data/archive',
    pinPath: './data/pins',
    taskPath: './data/tasks',
    blockPath: './block',
    blobPath: './blob',
    blobStagingPath: './data/blobstage',
    decreePath: './data/decrees',
    logPath: './data/logs',
    
    // Disable some security features for local development
    installMethod: 'unspecified',
    
    // Enable all applications by default
    availablePadTypes: [
        'drive',
        'teams',
        'sheet',
        'doc',
        'presentation',
        'pad',
        'kanban',
        'code',
        'form',
        'poll',
        'whiteboard',
        'file',
        'media',
        'todo',
        'contacts',
        'calendar',
        'diagram'
    ]
};
