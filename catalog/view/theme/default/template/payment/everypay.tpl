<form action="<?php echo $action === 1 ? 'https://pay.every-pay.eu/transactions/' : 'https://igw-demo.every-pay.com/transactions/' ; ?>" method="post">

    <?php foreach($form_data as $key => $value) { ?>
        <input type="hidden" name="<?php echo $key; ?>" value="<?php echo $value; ?>" />
    <?php } ?>

	<div class="buttons">
		<div class="right">
	    	<img src="catalog/view/theme/default/image/visa-mastercard.jpg" width="130"  style="margin-right: 15px; vertical-align: middle" />
	    	<input class="button" type="submit" value="Proceed to Payment" >
		</div>	
	</div>	
</form>
