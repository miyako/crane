# crane
Local inference engine

**aknowledgements**: [lucasjinreal/Crane](https://github.com/lucasjinreal/Crane)

The CLI is built for `4` platforms:

- macOS Apple Silicon, Intel 
- Windows AMD, ARM 

## Remarks

- `tokenizer.json` must be placed next to `.gguf`
- Qwen 3.5 not supported?

```sh
GGUF loaded: 320 tensors, 46 metadata entries
Error: cannot find tensor info for blk.0.attn_q.weight
``` 
