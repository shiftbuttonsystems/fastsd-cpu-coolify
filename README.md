# FastSD CPU Deployment on Coolify

**Credit:** Developed in collaboration with ChatGPT (OpenAI) for guidance on setup and deployment. If you want details of what FastSD CPU, you can visit Raphesh's repo https://github.com/rupeshs/fastsdcpu.

This guide will help you deploy FastSD CPU, a CPU-based Fast Stable Diffusion server, on the Coolify platform using Docker. By the end of this guide, you'll be able to generate images through API calls and optionally run a web UI.

## Assumptions
You already have a Coolify instance up and running.
You have basic knowledge of deploying applications via Docker on Coolify.
You want to deploy FastSD CPU with API endpoints accessible externally.
You have port 8000 reserved for Coolify; we will use 8001 for FastSD CPU.

**Step 1: Create Your Dockerfile**

Create a new project (e.g., fastsd-cpu), a production environment will automatically be created for you and inside it, add a new resource and select the option to use Dockerfile. Past the content of the Dockerfile inside it and save it.
**Notes on this Dockerfile:**

We use **Python 3.10 slim** for lightweight deployment.
Git is installed because we clone the FastSD CPU repository directly.
Libraries libgl1 and libglib2.0-0 are required for image processing.
The correct repository is https://github.com/rupeshs/fastsdcpu.git.
Port 8001 is used to avoid conflicts with Coolify itself.
We start FastSD CPU in API mode with --api.

**Step 2: Deploy on Coolify**

Next you cick on deploy and wait for it to deploy the resources. This may take some time. Y

**Stepb3: Deploy the link**

You can click link and click the url there. Do not worry if it shows {"detail":"Not Found"}. Right now you can only access it via api.
/api/info
/api/config
/api/models
/api/generate
 **Step 4: Test the Platform**
 enter your url http:your-serer-ip//api/info or http://your-domain:8001/api/info or http://your-domain/api/info or http://your-domain:8001/api/models or http://your-domain/api/models
 into a browser to test the api and get your server details.

**Step 5: Generate an Image via API**

Send a POST request to /api/generate with a JSON body:
curl -X POST "http://<your-app-subdomain>.your-coolify-domain/api/generate" \
-H "Content-Type: application/json" \
-d '{"prompt":"a cute cat","use_openvino":true}'
Returns a base64-encoded JPEG. You can decode it locally to view the generated image with a convert to file if using n8n.



You can decode it locally to view the generated image.
