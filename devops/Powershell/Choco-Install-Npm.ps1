choco install nodejs.install
# Re-load powershell environment before running the rest of these scripts.

# Display Node.js edition
node -v

# Display Node Package Manager edition
npm -v

# Install Angular.io
npm install -g @angular/cli

# Navigate to source folder
cd C:\Users\jamie.clayton\Documents\Source

ng new spike-ng-refresher
ng serve