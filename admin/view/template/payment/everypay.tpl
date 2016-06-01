<?php echo $header ?>
    <div id="content">
        <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php } ?>
        </div>
        <?php if ($error_warning) { ?>
            <div class="warning"><?php echo $error_warning; ?></div>
        <?php } ?>
        <div class="box">
            <div class="heading">
                
                <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title . " " . $version ?></h1>
                <div class="buttons">
                    <a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a>
                    <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
                </div>

            </div>

            <div class="content">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                    <table class="form">

                        <tr>
                            <td><?php echo $entry_status; ?></td>
                            <td><select name="everypay_status" id="input-status" class="form-control">
                                    <?php if ($everypay_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>

                        
                        <?php foreach ($everypay_title['languages'] as $language) :?>
                        <tr>
                            <td><!--<span class="required">*</span>--><?php echo htmlspecialchars($everypay_title['label']); ?>
                                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" />

                            </td>
                            <td><input type="text" name="<?php echo htmlspecialchars($everypay_title['name'] . '_' . $language['language_id']); ?>" value="<?php echo htmlspecialchars($everypay_title['value'][$everypay_title['name'] . '_' . $language['language_id']]); ?>" />
                            </td>
                        </tr>
                        <?php endforeach; ?>


                        <tr>
                            <td><span class="required">*</span> <?php echo $entry_api_username; ?></td>
                            <td><input type="text" name="everypay_api_username" value="<?php echo $everypay_api_username; ?>" placeholder="<?php echo $entry_api_username; ?>" required/>
                                <?php if ($error_api_username) { ?>
                                    <span class="error"><?php echo $error_api_username; ?></span>
                                <?php } ?>
                            </td>
                        </tr>

                        <tr>
                            <td><span class="required">*</span><?php echo $entry_api_secret; ?></td>
                            <td>
                                <input type="text" name="everypay_api_secret" value="<?php echo $everypay_api_secret; ?>" placeholder="<?php echo $entry_api_secret; ?>" id="input-key" class="form-control" required />
                                <?php if ($error_api_secret) { ?>
                                    <span class="error"><?php echo $error_api_secret; ?></span>
                                <?php } ?>
                            </td>
                        </tr>

                        <tr>
                            <td title="<?php echo $help_processing_account; ?>"><span class="required">*</span><?php echo $entry_account_id; ?><span class="help"><?php echo $help_processing_account ?></span></td>
                            <td>
                                <input type="text" name="everypay_account_id" value="<?php echo $everypay_account_id; ?>" placeholder="<?php echo $entry_account_id; ?>" class="form-control" required />
                                <?php if ($error_account_id) { ?>
                                    <span class="error"><?php echo $error_account_id; ?></span>
                                <?php } ?>
                            </td>
                        </tr>

                        <tr>
                            <td title="<?php echo $help_mode; ?>"><?php echo $entry_mode; ?><span class="help"><?php echo $help_mode ?></span></td>
                            <td>
                                <select name="everypay_mode" id="input-server" class="form-control">
                                    <?php if ($everypay_mode == 'live') { ?>
                                        <option value="live" selected="selected"><?php echo $text_live; ?></option>
                                    <?php } else { ?>
                                        <option value="live"><?php echo $text_live; ?></option>
                                    <?php } ?>
                                    <?php if ($everypay_mode == 'test') { ?>
                                        <option value="test" selected="selected"><?php echo $text_test; ?></option>
                                    <?php } else { ?>
                                        <option value="test"><?php echo $text_test; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td><?php echo $entry_test_api_username; ?></td>
                            <td>
                                <input type="text" name="everypay_test_api_username" value="<?php echo $everypay_test_api_username; ?>" placeholder="<?php echo $entry_test_api_username; ?>" class="form-control" />
                            </td>
                        </tr>

                        <tr>
                            <td><?php echo $entry_test_api_secret; ?></td>
                            <td>
                                <input type="text" name="everypay_test_api_secret" value="<?php echo $everypay_test_api_secret; ?>" placeholder="<?php echo $entry_test_api_secret; ?>" class="form-control" />
                                <input type="hidden" name="everypay_transaction_type" value="charge" />
                            </td>
                        </tr>

                        <!--                        <tr>-->
                        <!--                            <td>--><?php //echo $entry_transaction_type; ?><!--</td>-->
                        <!--                            <td>-->
                        <!--                                <select name="everypay_transaction_type" id="input-method" class="form-control">-->
                        <!--                                    --><?php //if ($everypay_transaction_type == 'authorization') { ?>
                        <!--                                        <option value="authorization" selected="selected">--><?php //echo $text_authorization; ?><!--</option>-->
                        <!--                                    --><?php //} else { ?>
                        <!--                                        <option value="authorisation">--><?php //echo $text_authorization; ?><!--</option>-->
                        <!--                                    --><?php //} ?>
                        <!--                                    --><?php //if ($everypay_transaction_type == 'charge') { ?>
                        <!--                                        <option value="charge" selected="selected">--><?php //echo $text_capture; ?><!--</option>-->
                        <!--                                    --><?php //} else { ?>
                        <!--                                        <option value="capture">--><?php //echo $text_capture; ?><!--</option>-->
                        <!--                                    --><?php //} ?>
                        <!--                                </select>-->
                        <!--                            </td>-->
                        <!--                        </tr>-->

                        <tr>
                            <td title="<?php echo $help_total; ?>"><?php echo $entry_total; ?><span class="help"><?php echo $help_total ?></span></td>
                            <td>
                                <input type="text" name="everypay_total" value="<?php echo $everypay_total; ?>" placeholder="<?php echo $entry_total; ?>" />
                            </td>
                        </tr>

                        <tr>
                            <td title="<?php echo $help_order_status; ?>"><?php echo $entry_order_status; ?><span class="help"><?php echo $help_order_status ?></span></td>
                            <td><select name="everypay_order_status_id" id="input-order-status" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $everypay_order_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td><?php echo $entry_geo_zone; ?></td>
                            <td>
                                <select name="everypay_geo_zone_id" id="input-geo-zone" class="form-control">
                                    <option value="0"><?php echo $text_all_zones; ?></option>
                                    <?php foreach ($geo_zones as $geo_zone) { ?>
                                        <?php if ($geo_zone['geo_zone_id'] == $everypay_geo_zone_id) { ?>
                                            <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td title="<?php echo $help_sort_order; ?>"><?php echo $entry_sort_order; ?><span class="help"><?php echo $help_sort_order ?></span></td>
                            <td><input type="text" name="everypay_sort_order" value="<?php echo $everypay_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" /></td>
                        </tr>

                    </table>
                </form>
            </div>
        </div>
    </div>
<?php echo $footer; ?>