# A Machine Learning-Based Intrusion Detection System for the Internet of Medical Things

### Description

This repository contains the final project for the Computer Engineering Bachelor Degree of <a href="https://github.com/ivoafonsobispo">Ivo Bispo</a> and <a href="https://github.com/joseareia">José Areia</a>, focusing on the development of a Machine Learning-Based Intrusion Detection System (IDS) for the Internet of Medical Things (IoMT).

The Internet of Medical Things refers to the interconnected network of medical devices and healthcare systems that collect and exchange patient data. While the IoMT brings numerous benefits, it also introduces security challenges, making it crucial to have robust intrusion detection mechanisms in place.

The goal of this project is to leverage machine learning techniques to develop an effective IDS that can detect and mitigate potential intrusions within an IoMT environment. 

### Repository Content

The repository offers various resources to support the objectives mention above, including:

- `Attacks` A folder that contains various source code attacks performed on the IoMT network. It includes implementations of known attack techniques, such as replay, injection, and denial-of-service attacks.

- `Captures` Contains a collection of IP-based and BLE (Bluetooth Low Energy) captures. Analyzing these captures can help in identifying patterns, anomalies, and potential security breaches.

- `Datasets` This folder contains all the datasets developed in the project, including BLE datasets and IP-Based datasets. These datasets provide valuable information and real-world examples of network traffic and communication within an IoMT system.

- `Network Diagrams` Visual representations of the network architecture and communication flow within an IoMT system. These diagrams help in understanding the infrastructure and identifying potential attack vectors.

- `Related Documents` Supplementary documents, including project requirements, system specifications, and design considerations, which provide insights into the project's scope and overall development process.

- `IoMT Scenario Code` Implementations of CoAP (Constrained Application Protocol) and MQTT (Message Queuing Telemetry Transport) servers and clients for Arduino Yun and ESP32 microcontrollers. These implementations demonstrate how to establish secure communication channels between IoMT devices, and form a basis for the IDS development.

- `Scripts` This folder contains two scripts that are used in the project. The "BLE Fields Extractor" script is designed to extract all the fields in a BLE PCAP file, providing insights into device identifiers, UUIDs, data payloads, and other relevant information. The "Untitled192" script is used in the MQTT and COAP server. It starts and stops the servers while capturing traffic in rotating one-hour log files.

### Final Note

By leveraging the resources provided in this repository, developers, researchers, and security enthusiasts can gain a deeper understanding of IoMT security challenges and explore innovative approaches to developing robust intrusion detection systems. Feel free to explore the code, articles, and documents to enhance your knowledge and contribute to the advancement of secure IoMT systems.

### Contributors & Authors

If you have any questions or want to contribute to this project in any terms, contact the authors of this project:

- Ivo Bispo - `2201739@my.ipleiria.pt`
- José Areia - `2200655@my.ipleiria.pt`

### Acknowledgements

We would like to express our sincere gratitudes to Professor Leonel Santos and Researcher Rogério Costa for their invaluable guidance and support throughout the development of this final project.

