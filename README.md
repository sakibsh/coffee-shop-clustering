# Coffee Shop Clustering: Understanding Customer Behavior with AIoT

Leverage the power of customer sequence data to create behavior-based clusters in a coffee shop setting. This dataset and approach provide valuable insights into customer behavior, enabling personalized experiences in smart café environments.

### What’s Inside:

- **Customer Behavior Sequences**: Each customer's activity is captured as a sequence, with noisy data labeled as 'Unknown' due to continuous movement within the café. Other sequences are labeled according to behavior observed around seven specific zones in the shop.

- **Advanced Clustering Techniques**: Given that traditional distance algorithms like Euclidean and Manhattan are unsuitable for sequential data, we utilize advanced techniques such as Optimal Matching (OM), Longest Common Prefix (LCP), and Longest Common Subsequence (LCS) distances for accurate clustering.

![Shop Layout](https://github.com/SakibShahriar95/coffee-shop-clustering/blob/master/Coffee%20Shop%20Outline.JPG)

### Explore the Research:

For a detailed discussion of the methodology and findings, refer to the following papers:

- **Zualkernan, Imran A., Michel Pasquier, Sakib Shahriar, Mohammed Towheed, and Shilpa Sujith. "Using BLE beacons and machine learning for personalized customer experience in smart Cafés."** In *2020 International Conference on Electronics, Information, and Communication (ICEIC)*, pp. 1-6. IEEE, 2020.
- **Shahriar, Sakib, Imran Zualkernan, Michel Pasquier, Ayesh Towheed, and Shilpa Sujith. "An AIoT-Based Smart Café System."** Available at SSRN: [https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4448815](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4448815)

---

### Abstract:

Personalized service is a key focus in various sectors, including retail, restaurants, and cafes. Despite technological advancements, achieving true personalization remains challenging. This research presents the design and implementation of a pervasive smart café system that utilizes the Internet of Things (IoT) integrated with Artificial Intelligence (AIoT) to enhance customer experiences.

The proposed system offers several features to café visitors:
- **Personalized Content Delivery**: Tailored experiences using unsupervised machine learning.
- **Automatic Table Reservation**: Based on customer preferences detected upon entry.
- **Enhanced Customer Interaction**: Facilitated through a barista interface, allowing personalized interactions.
- **Real-Time Monitoring**: Customers can track real-time conditions in the café via a mobile application.

The system architecture relies on MQTT and an NSQL database. By analyzing historical traces of customer behavior captured via Bluetooth Low Energy (BLE) beacons, the study creates clusters of similar customers. The most effective clustering algorithms identified were K-Medoids, Hierarchical, and Spectral clustering using OM and LCS distances, achieving an Adjusted Rand Index (ARI) of 0.872, 0.802, 0.854 with OM, and 0.832, 0.777, 0.856 with LCS, respectively. For labeled clusters, Hierarchical Clustering with OM yielded the best results with an F1-Score of 0.937.

This approach highlights the potential of AIoT in creating truly personalized customer experiences in smart café environments.
