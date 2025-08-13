---
title: User Interface
---

The User Interface of dxflow designed to be intuitive and user-friendly, allowing users to easily navigate through the various features and functionalities of the dxflow engine. It is accessible via a web browser and provides a comprehensive overview of the workflows, tasks, and resources managed by dxflow.

In order to have this interface, you need to have the dxflow engine installed and running. You can check if it is installed by running the following command:

```bash
dxflow engine up 
```
which prints the status of the dxflow engine. If it is running, you will see a message indicating that the engine is up and running
```bash
Engine successfully booted (use 'CTRL+C' to stop) [~/.dxflow/unix.sock] [0.0.0.0:80]
```

If you don't assign any port to the engine, it will run on port 80 by default. You can access the UI by opening your web browser and navigating to `http://localhost` or `http://<your-server-ip>` if you are running it on a remote server.

![](/assets/ui_start_dark.png)