---
layout: default
---

![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/crane)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/crane/total)

# Use crane from 4D

#### Abstract

[**crane-oai**](https://github.com/lucasjinreal/Crane) is a Rust based alternative to llama.cpp, optimised for LLM, VLM, VLA, TTS, OCR inference. Embeddings or reranker models are **not** supported.

#### AI Kit compatibility

The API is compatibile with [Open AI](https://platform.openai.com/docs/api-reference/embeddings). 

|Class|API|Availability|
|-|-|:-:|
|Models|`/v1/models`|✅|
|Chat|`/v1/chat/completions`|✅|
|Images|`/v1/images/generations`||
|Moderations|`/v1/moderations`||
|Embeddings|`/v1/embeddings`||
|Files|`/v1/files`||
