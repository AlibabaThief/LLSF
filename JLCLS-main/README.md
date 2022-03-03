# Joint label completion and label-specific features for multi-label learning algorithm (JLCLS)
## Abstract
Label correlations have always been one of the hotspots of multi-label learning. Using label correlations to complete the original label can enrich the information of the label matrix. At the same time, label-specific features give a thought that different labels have inherent characteristics that can be distinguished, and we can use label correlations to enhance the learning process of label-specific features among similar labels. At present, most of the algorithms combine label correlations and label-specific features to improve the multi-label learning effect, but do not consider the impact of label marking errors or defaults in data sets. In fact, the label completion method can further enrich the information of label matrix, and then the joint learning framework of joint label-specific features can effectively improve the robustness of the multi-label learning algorithm. Based on this, this paper proposes a multi-label learning algorithm for joint label completion and label-specific features, and constructs a new multi-label learning algorithm framework by means of joint label completion and label-specific features. Completion matrix and label-specific features are obtained by alternating iteration method, and the label matrix updating the optimization framework fully considers the label correlations. The algorithm in this paper has been demonstrated and trained on several benchmark multi-label data sets by extensive experiments, which verifies the effectiveness of the algorithm.
## Data preparation
You need to download the [datasets](http://www.kecl.ntt.co.jp/as/members/ueda/yahoo.tar)
## Citation
If you find this work or code is helpful in your research, please cite:
````
@title={Joint label completion and label-specific features for multi-label learning algorithm},
  author={Yibin Wang and Weijie Zheng and Yusheng Cheng and Dawei Zhao},
  journal={soft computing},
  year={2020}
