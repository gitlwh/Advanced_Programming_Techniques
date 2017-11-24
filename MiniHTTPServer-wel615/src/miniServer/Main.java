package miniServer;

/* CSE 264 - Fall 2014
 * Homework #1 - Mini HTTP Server
 * Name:Weiheng Li
 * Date:Sep 27 2017
 */

import java.io.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

public class Main {
    // The port can be any small integer that isn't being used by another program
    private static final int port = 8567;

    public static void main(String[] args) {
        try {
            System.out.println("Mini HTTP Server Starting Up");
            // Listen on port for a new connection request
            ServerSocket s = new ServerSocket(port);
            for (;;) {
               
                // Wait for a new TCP connection to come in from a client and 
                // accept it when it does. Return a reference to the socket 
                // that will be used to communicate with the client.
                Socket newSocket = s.accept();
                System.out.println("New connection from: " + ((InetSocketAddress)newSocket.getRemoteSocketAddress()).getAddress().getHostAddress());
                String str = ((InetSocketAddress)newSocket.getRemoteSocketAddress()).getAddress().getHostAddress();
                BufferedWriter writer = new BufferedWriter(new FileWriter("access.log",true));
                writer.write(str+" - ");
                 
                writer.close();
                // Create a new handler object to handle the requests of the 
                // client that just connected.
                ClientHandler handler = new ClientHandler(newSocket);
                
                // Give the handler its own thread to handle requests to that 
                // the server can handle multiple clients simultaneously.
                new Thread(handler).start();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

class ClientHandler implements Runnable {
    // Socket used to handle the client requests.
    private Socket socket;

    public ClientHandler(Socket s) {
        this.socket = s;
    }

    @Override
    public void run() {
        try {
            BufferedReader request = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            DataOutputStream response = new DataOutputStream(socket.getOutputStream());
            List<String> headers = new ArrayList<>();

            try {
                String firstLine = request.readLine();
                if (firstLine.length() > 0) {
                    // Read Headers, one per line of the request
                    String line;
                    while ((line = request.readLine()).length() > 0) {
                        headers.add(line);
                    }
                    // Break the request line up unto individual token
                    String[] tokens = firstLine.split(" ");
                    
                    // The first token is the method name (GET, POST, etc.)
                    String method = tokens[0];
                    
                    // The second token is the resource being requested (eg. /index.html)
                    String resource = tokens[1];
                    
                    // Dump the entire request to the console for debugging
                    dumpRequest(firstLine, headers);
                    BufferedWriter writer = new BufferedWriter(new FileWriter("access.log",true));
                    writer.write("\""+firstLine+"\" ");
                     
                    writer.close();
                    // Process the request based on the method used (GET is the only
                    // one we're implementing for now
                    int responseCode = 0;
                    switch (method) {
                        case "GET":
                        	//System.out.println("get1");
                            responseCode = processGET(resource, headers, response);
                            break;
                        case "POST":
                            System.err.println(method + " method not implemented.");
                            break;
                        case "HEAD":
                            System.err.println(method + " method not implemented.");
                            break;
                        case "PUT":
                            System.err.println(method + " method not implemented.");
                            break;
                        case "DELETE":
                            System.err.println(method + " method not implemented.");
                            break;
                        case "TRACE":
                            System.err.println(method + " method not implemented.");
                            break;
                        case "OPTIONS":
                            System.err.println(method + " method not implemented.");
                            break;
                        default:
                            System.err.println("Unknown method: " + method);
                            break;
                    }
                }
            } catch (Exception e) {
               // If we get an i/o error, tell the user that the resource is unavailable
               response.writeBytes("HTTP/1.1 404 ERROR\n\n");
               BufferedWriter writer = new BufferedWriter(new FileWriter("access.log",true));
               writer.write("404\n");
                
               writer.close();
            }
            // Clean up once the request has been processed
            request.close();
            response.close();
        } catch (Exception ex1) {
            System.out.println("Internal error: " + ex1.getMessage());
        }
    }

    // Write out the request header lines to the console
    private void dumpRequest(String firstLine, List<String> headers) {
        
        System.out.println(firstLine);
        for (String headerLine : headers) {
            System.out.println(headerLine);
        }
        System.out.println();
    }

    private int processGET(String resource, List<String> headers, DataOutputStream out) {
        try {
        	//System.out.println("get2");
            // Default to index.html
            if (resource.endsWith("/")) {
                resource += "index.html";
            }

            // Create file path from requested resource compatable with the host OS
            String path = ("." + resource).replace('/', File.separatorChar);
            int length = (int) new File(path).length();
            String extension = path.substring(path.lastIndexOf("."));
            byte[] b = new byte[length];

            // Read the requested resource into an array of bytes
            FileInputStream resourceStream;
            try {
                resourceStream = new FileInputStream(path);
                resourceStream.read(b);
            } catch (IOException ex) {
                out.writeBytes("HTTP/1.1 404 ERROR\n\n");
                BufferedWriter writer = new BufferedWriter(new FileWriter("access.log",true));
                writer.write("404\n");
                 
                writer.close();
                return 404;
            }

            // Write HTTP response line to client
            out.writeBytes("HTTP/1.1 200 OK\n");
            
            // Write out the headers
            out.writeBytes("Content-Length:" + length + "\n");
            //System.out.println(extension);
            switch(extension){
            case ".gif":
            	out.writeBytes("Content-Type: image/gif\n");
            	break;
            case ".jpg":
            	out.writeBytes("Content-Type: image/jpg\n");
            	break;
            case ".png":
            	out.writeBytes("Content-Type: image/png\n");
            	break;
            case ".pdf":
            	out.writeBytes("Content-Type: application/pdf\n");
            	break;
            case ".xls":
            	out.writeBytes("Content-Type: application/vnd.ms-excel\n");
            	break;
            case ".xlsx":
            	out.writeBytes("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet\n");
            	break;
            case ".htm":
            	out.writeBytes("Content-Type: text/htm\n");
            	break;
            case ".html":
            	out.writeBytes("Content-Type: text/html\n");
            	break;
            }
            
            //out.writeBytes(new File(path).lastModified());
            //System.out.println(new File(path).lastModified());
            
            SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z");
            sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
            File file = new File(path);
            
        	out.writeBytes("Last-Modified: " + sdf.format(file.lastModified())+"\n");
            
            out.writeBytes("Connection: close\n");
            
            // Blank line ends the header section
            out.writeBytes("\n"); 
            
            // Send the requested resource to the client
            out.write(b, 0, length);
            
            // Return code 200 means "Successful"
            /*String str = "\"GET "+resource+" HTTP/1.1\"\n";
            BufferedWriter writer = new BufferedWriter(new FileWriter("log.txt",true));
            writer.write(str);
             
            writer.close();*/
            BufferedWriter writer = new BufferedWriter(new FileWriter("access.log",true));
            writer.write("200\n");
             
            writer.close();
            
            
            
            return 200;
        } catch (IOException ex) {
            try {
                out.writeBytes("HTTP/1.1 500 ERROR\n\n");
                BufferedWriter writer = new BufferedWriter(new FileWriter("access.log",true));
                writer.write("500\n");
                 
                writer.close();
                return 500;
            } catch (IOException ex1) {
                System.out.println("Internal error: " + ex1.getMessage());
                return 500;
            }
        }
    }
}
