# Project_Review_1_Multimodal_Hallucination_Firewall _1_.pdf

pages: 6
sha256: c043b202797d02c0a85dd322fc6ff4dc0ca3d4cd385e63645824b2023e1de7bb

--- page 1 ---
Multimodal Hallucination Firewall | Project Review 1 | 1
PROJECT REVIEW 1
Multimodal Hallucination Firewall
Evidence-Based Hallucination Detection for Multimodal RAG Systems
Project Theme Combining multimodal AI, retrieval-augmented generation, and
machine learning to detect unsupported or contradictory
AI-generated responses using visual and textual evidence.
Course M.Sc. Artificial Intelligence & Machine Learning
Subject Machine Learning
Submitted To Dr. Durai Raj Vincent P.M.
Submitted By Arya Yadav - 26MAG0026
Divyanshu Kandpal - 26MAG0028
Institution Vellore Institute of Technology, Vellore

--- page 2 ---
Multimodal Hallucination Firewall | Project Review 1 | 2
Multimodal Hallucination Firewall — Project Review 1
1. Abstract
Generative AI systems can produce fluent and confident responses containing information that is not supported
by available evidence. This challenge becomes more difficult in multimodal systems, where information may be
distributed across images, text, and retrieved documents.
This project proposes a Multimodal Hallucination Firewall, an AI-assisted verification framework for
Retrieval-Augmented Generation (RAG) systems. The framework will accept multimodal inputs such as an
image and a text query, retrieve relevant supporting information, generate an answer, and then verify whether
important claims are supported by visual and textual evidence.
The central research direction is to combine semantic similarity, image-text alignment, claim verification, and
machine-learning-based risk classification to distinguish grounded responses from potentially hallucinated
responses.
Core Research Idea: Can multimodal evidence and machine-learning-based verification improve detection of
unsupported claims in RAG-generated answers?
2. Keywords
Keywords: Multimodal AI; Hallucination Detection; RAG; Generative AI; Computer Vision; Natural Language
Processing; Vision-Language Models; Evidence Verification; Machine Learning; Responsible AI.
3. Data Description
The project will use multimodal samples containing an image, a text question or prompt, supporting evidence
where applicable, and an answer or claim to be verified. The final dataset/source will be selected based on
suitability for multimodal hallucination and faithfulness evaluation.
3.1. Basic Data Preparation Process
Image + Question → Evidence Retrieval → Multimodal Answer Generation → Claim Extraction → Evidence
Verification → Grounded / Hallucinated Label

--- page 3 ---
Multimodal Hallucination Firewall | Project Review 1 | 3
Multimodal Hallucination Firewall — Project Review 1
3.2. Dataset Characteristics
Parameter Description
Data Type Multimodal image-text and evidence-based data
Primary Modalities Image + text; retrieved textual evidence may also be used
Input Image and user question / prompt
Evidence Retrieved or associated textual and visual information
Learning Target Grounded / unsupported / contradictory response or
hallucination-risk score
Key Features Text similarity, image-text alignment, entailment, entity and
numerical consistency
4. Proposed Verification Framework
The firewall operates after answer generation and evaluates the response against the evidence available to the
system. Multiple complementary signals will be investigated instead of relying on a single similarity score.
Verification Signal Purpose
Semantic Similarity Measures agreement between the answer and retrieved textual
evidence.
Image-Text Alignment Measures compatibility between visual content and textual
claims.
Claim Verification /
NLI
Checks whether evidence supports, contradicts, or does not
support a claim.
Entity Consistency Checks important objects, names, locations and attributes.
Numerical
Consistency
Checks quantities, dates, prices, percentages and specifications.
Illustrative example: If a product image and supporting specification identify a processor as Intel Core i7, but
the generated answer states Intel Core i9, the firewall should identify the contradiction and assign a higher
hallucination risk.
5. Outcomes
The project is intended to produce the following outcomes:
1. Develop a multimodal RAG environment for evidence-grounded question answering.
2. Build a verification layer for detecting unsupported or contradictory generated claims.
3. Investigate whether combining visual and textual evidence improves hallucination detection.
4. Develop machine-learning features and a classifier/risk-scoring mechanism for response verification.
5. Compare verification signals and study their contribution to detection performance.

--- page 4 ---
Multimodal Hallucination Firewall | Project Review 1 | 4
6. Develop an interactive prototype demonstrating answer generation, evidence checking and hallucination-risk
scoring.

--- page 5 ---
Multimodal Hallucination Firewall | Project Review 1 | 5
Multimodal Hallucination Firewall — Project Review 1
6. Project Direction
The overall direction of the proposed system can be summarized as:
Image + Question
↓
Visual / Multimodal Analysis
↓
RAG Retrieval
↓
Retrieved Evidence
↓
Multimodal LLM
↓
Generated Answer
↓
HALLUCINATION FIREWALL
■ ■
Visual Evidence Check Text Evidence Check
■ ■
Machine-Learning Risk Scoring
↓
SAFE / WARNING / HALLUCINATION
↓
Verified Answer or Regeneration
7. Project Focus
The project will investigate whether multimodal evidence verification can improve the reliability of
RAG-generated answers. Particular attention will be given to the relationship between visual evidence, retrieved
textual evidence, generated claims, and the final hallucination-risk decision.
8. Expected Project Contribution
The expected contribution is a hybrid framework combining multimodal evidence, RAG, and machine
learning to identify potentially hallucinated responses. The system is intended to provide not only an answer,
but also an interpretable verification outcome indicating why a response is considered grounded or risky.
9. Initial Technology Direction
Component Possible Direction
Vision /
Vision-Language
CLIP, BLIP/BLIP-2, or a suitable vision-language model
Text Representation Sentence-transformer or comparable embeddings
Retrieval FAISS or another vector-search mechanism
ML Classifier Logistic Regression, Random Forest, SVM or XGBoost

--- page 6 ---
Multimodal Hallucination Firewall | Project Review 1 | 6
Evaluation Accuracy, Precision, Recall, F1-score and ROC-AUC
Project Objective: To develop and evaluate a multimodal AI verification layer that reduces the risk of
unsupported information being presented as a reliable answer.
Note: Detailed model architecture, final dataset selection, experimental comparisons, quantitative results, and
the complete prototype will be developed and presented in subsequent project reviews.
