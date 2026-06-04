Class extends _crane

Class constructor($controller : 4D:C1709.Class)
	
	Super:C1705("crane-oai"; $controller)
	
Function start($option : Object) : 4D:C1709.SystemWorker
	
	This:C1470.bind($option; ["onTerminate"])
	
	var $command : Text
	$command:=This:C1470.escape(This:C1470.executablePath)
	
	Case of 
		: (Value type:C1509($option.model)=Is object:K8:27)\
			 && (OB Instance of:C1731($option.model; 4D:C1709.File))\
			 && ($option.model.exists)
			$command+=" --model-path "
			$command+=This:C1470.escape(This:C1470.expand($option.model).path)
			$command+=" "
	End case 
	
	var $arg : Object
	var $valueType : Integer
	var $key : Text
	
	For each ($arg; OB Entries:C1720($option))
		Case of 
			: (["model"; "help"].includes($arg.key))
				continue
		End case 
		$valueType:=Value type:C1509($arg.value)
		$key:=Replace string:C233($arg.key; "_"; "-"; *)
		Case of 
			: ($valueType=Is real:K8:4)
				$command+=(" --"+$key+" "+String:C10($arg.value)+" ")
			: ($valueType=Is text:K8:3)
				$command+=(" --"+$key+" "+This:C1470.escape($arg.value)+" ")
			: ($valueType=Is boolean:K8:9) && ($arg.value)
				$command+=(" --"+$key+" ")
			: ($valueType=Is object:K8:27) && (OB Instance of:C1731($arg.value; 4D:C1709.File)) && ($arg.value.exists)
				$command+=(" --"+$key+" "+This:C1470.escape(This:C1470.expand($arg.value).path))+" "
			: ($valueType=Is object:K8:27) && (OB Instance of:C1731($arg.value; 4D:C1709.Folder)) && ($arg.value.exists)
				$command+=(" --"+$key+" "+This:C1470.escape(This:C1470.expand($arg.value).path))+" "
			: ($valueType=Is collection:K8:32)
				var $value : Variant
				For each ($value; $arg.value)
					$valueTypeValue:=Value type:C1509($value)
					Case of 
						: ($valueTypeValue=Is real:K8:4)
							$command+=(" --"+$key+" "+String:C10($value)+" ")
						: ($valueTypeValue=Is text:K8:3)
							$command+=(" --"+$key+" "+This:C1470.escape($value)+" ")
						: ($valueTypeValue=Is boolean:K8:9) && ($value)
							$command+=(" --"+$key+" ")
						: ($valueTypeValue=Is object:K8:27) && (OB Instance of:C1731($value; 4D:C1709.File)) && ($value.exists)
							$command+=(" --"+$key+" "+This:C1470.escape(This:C1470.expand($value).path))+" "
					End case 
				End for each 
			Else 
				//
		End case 
	End for each 
	
	This:C1470.controller.variables:={\
		CRANE_FORCE_GPU_TOPK: 0; \
		CRANE_TOPP_FALLBACK_TOPK: 64; \
		CRANE_TOPK_SAMPLE_ON_CPU: 0; \
		CRANE_SAMPLE_TRACE: 0}
	
	ALERT:C41($command)
	
	return This:C1470.controller.execute($command).worker