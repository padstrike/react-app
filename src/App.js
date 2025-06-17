import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h1>React Static Website on AWS S3</h1>
        <p>
          This website is hosted on AWS S3 and deployed using CI/CD pipeline.
        </p>
        <div className="deployment-info">
          <p>Deployment Time: {new Date().toLocaleString()}</p>
          <p>Build Version: 1.0.0</p>
        </div>
        <a
          className="App-link"
          href="https://aws.amazon.com/s3/"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn about AWS S3
        </a>
      </header>
    </div>
  );
}

export default App;
