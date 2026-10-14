# Project_Review_2_Multimodal_Hallucination_Firewall.pdf

pages: 6
sha256: 2f6f7658c59a7a0b7c18930c21f1036aa071f104ec61e40bf3e8ee6bf22d7ead

--- page 1 ---
M.Sc. Artificial Intelligence & Machine Learning | VIT Vellore 1
PROJECT REVIEW 2
Multimodal
Hallucination Firewall
Evidence-Based AI Answer Verification
Progress report: interactive web prototype, evidence analysis and current limitations
COURSE M.Sc. Artificial Intelligence & Machine Learning
SUBJECT Machine Learning
TEAM MEMBERS Arya Yadav — 26MAG0026
Divyanshu Kandpal — 26MAG0028
INSTITUTION Vellore Institute of Technology, Vellore
The prototype has progressed from the proposed verification framework in Review 1 to a working web interface that
accepts visual evidence and tests whether an AI-generated answer is consistent with it.

--- page 2 ---
MULTIMODAL HALLUCINATION FIREWALL PROJECT REVIEW 2
M.Sc. Artificial Intelligence & Machine Learning | VIT Vellore 2
1. Progress since Project Review 1
The first review described the intended direction: combine visual and textual evidence with machine-learning-based
risk scoring to identify answers that are unsupported or contradictory. The current milestone is an interactive Streamlit
website that demonstrates the verification stage using an uploaded image, a question and a supplied AI answer.
What is implemented in the current prototype
COMPONENT CURRENT ROLE
Image and prompt input The user uploads an image and enters a question to define what should be
checked.
Answer verification input The user enters an AI-generated answer; the prototype evaluates its
consistency with the image.
CLIP-based visual evidence The interface displays image–text/object evidence scores, including
present-versus-absent evidence for a queried object.
SVM risk classification A support/risk estimate is shown as a hallucination probability, together with
a firewall verdict.
Interpretable result page The verdict screen presents the queried object, evidence scores, risk level
and a short explanation of the decision.
Current verification flow
1. Upload image 2. Enter question 3. Enter AI answer
Visual input Defines the claim to inspect Candidate response
4. Extract CLIP features 5. SVM risk assessment 6. Firewall verdict
Image–text/object signals Estimates unsupported-answer
risk
Supported or hallucinated
Scope note: the screenshots demonstrate the verification interface and its decision pipeline. They do not establish that document retrieval,
RAG-based evidence retrieval, or automatic answer generation is already integrated into the website.

--- page 3 ---
MULTIMODAL HALLUCINATION FIREWALL PROJECT REVIEW 2
M.Sc. Artificial Intelligence & Machine Learning | VIT Vellore 3
2. Demonstration A — Contradictory answer
Question: “Is there a phone in the image?”
The uploaded scene contains a laptop on a table and a small phone near the bottom-centre area, below the laptop. In
this run, the supplied answer says that the phone is not visible. The firewall marks the answer as HALLUCINATED
because the answer conflicts with the object-level evidence shown by the prototype.
Figure 1. Input screen: uploaded image, question and answer denying the phone’s presence.
Figure 2. Verdict screen: the prototype flags an object-presence contradiction.

--- page 4 ---
MULTIMODAL HALLUCINATION FIREWALL PROJECT REVIEW 2
M.Sc. Artificial Intelligence & Machine Learning | VIT Vellore 4
3. Demonstration B — Visually supported answer
The same image and question are used, but the answer now states that the phone is visible near the bottom centre,
below the laptop. The firewall labels this response SUPPORTED. Using the same scene for both runs makes the
comparison useful: the answer changes while the visual evidence remains fixed.
Figure 3. Input screen: answer identifies the phone’s location in the image.
Figure 4. Verdict screen: the prototype accepts the answer as visually supported.

--- page 5 ---
MULTIMODAL HALLUCINATION FIREWALL PROJECT REVIEW 2
M.Sc. Artificial Intelligence & Machine Learning | VIT Vellore 5
4. Results from the two prototype runs
The following values are read directly from the supplied screenshots. They describe these two demonstrations only
and should not be interpreted as benchmark performance.
MEASURE Contradictory answer Supported answer
Firewall verdict HALLUCINATED SUPPORTED
Queried object Phone Phone
Object-present score 0.1881 0.1881
Object-absent score 0.1744 0.1744
SVM hallucination probability 77.7% 18.6%
Additional displayed values Object-presence conflict Image–question: 0.1966
Image–answer: 0.2288
Grounding: 0.2127
Interpretation
The prototype produces different risk outputs for the two answer variants: 77.7% for the denial and 18.6% for the
location-specific answer. The present score (0.1881) is only slightly higher than the absent score (0.1744), a margin of
0.0137. This is a narrow separation, so the object-level result should be treated as a useful signal rather than definitive
proof. The screenshots show that the interface can expose evidence and a verdict; they do not show whether these
scores are calibrated or how often the classifier is correct across a dataset.
Important distinction: CLIP similarity values are not probabilities of truth. The displayed SVM risk is a model output and needs validation and,
ideally, calibration before being presented as a reliable confidence estimate.

--- page 6 ---
MULTIMODAL HALLUCINATION FIREWALL PROJECT REVIEW 2
M.Sc. Artificial Intelligence & Machine Learning | VIT Vellore 6
5. Current limitations and next improvements
The next phase should focus on reliability and measurable evaluation, not only adding more interface elements.
1. Expand the labelled test set
Build a diverse collection of image–question–answer examples covering multiple object categories, absent objects,
occlusion, small objects, cluttered scenes, and hard negatives. Record labels consistently.
2. Train and validate the SVM properly
Use a stratified train/validation/test split, prevent near-duplicate leakage, and apply cross-validation on the training
portion. Compare against a simple baseline and check class balance.
3. Report real evaluation metrics
Measure precision, recall, F1-score, ROC-AUC and a confusion matrix on held-out data. Include threshold-sensitivity
results and explain which error matters most for the intended use.
4. Calibrate the risk score
Check whether predicted risk corresponds to observed error frequency. Tune the decision threshold using validation
data, and consider an “uncertain / needs review” outcome when evidence is weak.
5. Strengthen evidence grounding
Move beyond a single object-level similarity comparison where possible: extract answer claims, check each claim
against visual evidence, and show which claim triggered the warning. Add explicit handling for ambiguous or
unrecognisable content.
6. Improve robustness and usability
Test different image sizes, file types and upload failures; add clear error messages, reproducible logs and a short
explanation of the evidence behind each verdict.
Planned evaluation table
Evaluation item What it will establish
Held-out test set Performance on examples not used for fitting or threshold
selection.
Confusion matrix + precision/recall/F1 Types of errors and the balance between missed hallucinations
and false alarms.
Threshold comparison How the verdict changes as the risk threshold is adjusted.
Ablation study Whether CLIP/object evidence and SVM scoring each contribute
useful signal.
6. Summary
Project Review 2 demonstrates a working web interface for evidence-based answer verification. In the supplied
example, the firewall distinguishes an answer that denies a visible phone from an answer that correctly identifies it,
and presents the decision with object-level scores and an SVM risk estimate. The immediate priority is to establish
reliability through a larger labelled dataset, disciplined validation, calibrated thresholds and transparent metrics before
making broader claims about hallucination detection.
