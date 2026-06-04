var $crane : cs:C1710.crane

var $homeFolder : 4D:C1709.Folder
$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".GGUF")

var $file : 4D:C1709.File
var $URL : Text
var $port : Integer
var $huggingface : cs:C1710.event.huggingface

var $event : cs:C1710.event.event
$event:=cs:C1710.event.event.new()
/*
        Function onError($params : Object; $error : cs.event.error)
        Function onSuccess($params : Object; $models : cs.event.models)
        Function onData($request : 4D.HTTPRequest; $event : Object)
        Function onResponse($request : 4D.HTTPRequest; $event : Object)
        Function onTerminate($worker : 4D.SystemWorker; $params : Object)
 */

$event.onError:=Formula:C1597(ALERT:C41($2.message))
$event.onSuccess:=Formula:C1597(ALERT:C41($2.models.extract("name").join(",")+" loaded!"))
$event.onData:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; This:C1470.file.fullName+":"+String:C10((This:C1470.range.end/This:C1470.range.length)*100; "###.00%")))
$event.onData:=Formula:C1597(MESSAGE:C88(This:C1470.file.fullName+":"+String:C10((This:C1470.range.end/This:C1470.range.length)*100; "###.00%")))
$event.onResponse:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; This:C1470.file.fullName+":download complete"))
$event.onResponse:=Formula:C1597(MESSAGE:C88(This:C1470.file.fullName+":download complete"))
$event.onTerminate:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; (["process"; $1.pid; "terminated!"].join(" "))))

var $folder : 4D:C1709.Folder
var $path : Text

$port:=8081

$folder:=$homeFolder.folder("gemma-4-E2B")
$path:="gemma-4-E2B-it-q4_k_m.gguf"
$URL:="keisuke-miyako/gemma-4-E2B-it-gguf"

$batches:=4
$max_position_embeddings:=8192

var $logFile : 4D:C1709.File
$logFile:=$folder.file("crane.log")
$folder.create()
If (Not:C34($logFile.exists))
	$logFile.setContent(4D:C1709.Blob.new())
End if 

var $options : Object

$options:={\
max_seq_len: $max_position_embeddings*$batches; \
max_concurrent: $batches}

var $huggingfaces : cs:C1710.event.huggingfaces

$huggingface:=cs:C1710.event.huggingface.new($folder; $URL; [$path])
$huggingfaces:=cs:C1710.event.huggingfaces.new([$huggingface])

$crane:=cs:C1710.crane.new($port; $huggingfaces; $homeFolder; $options; $event)