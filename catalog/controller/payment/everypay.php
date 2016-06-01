<?php

class ControllerPaymentEverypay extends Controller
{
    public function index ()
    {

        include_once DIR_APPLICATION . '../system/library/Everypay.php';

        $this->load->language('payment/everypay');
        $this->load->model('checkout/order');
        $this->load->model('payment/everypay');

        $this->model_payment_everypay->updatePaymentTitle($this->session->data['order_id']);
        $order = $this->model_checkout_order->getOrder($this->session->data['order_id']);



        $fields = array(
            'account_id' => $this->config->get('everypay_account_id'),
            'amount' => $order['total'],
            'billing_address' => $order['payment_address_1'] . $order['payment_address_2'],
            'billing_city' => $order['payment_city'],
            'billing_country' => $order['payment_iso_code_2'],
            'billing_postcode' => $order['payment_postcode'],
            //in case of automatic response, reroute the callback HTTP request to controller
            'callback_url' => HTTP_SERVER . 'everypay_validate.php',
            'customer_url' => HTTP_SERVER . 'index.php?route=payment/everypay/process',
            'delivery_address' => $order['shipping_address_1'] . $order['shipping_address_2'],
            'delivery_city' => $order['shipping_city'],
            'delivery_country' => $order['shipping_iso_code_2'],
            'delivery_postcode' => $order['shipping_iso_code_2'],
            'email' => $order['email'],
            'order_reference' => $order['order_id'],
            'user_ip' => $order['ip'],
            'hmac_fields' => 'api_username,account_id,amount,billing_address,billing_city,billing_country,billing_postcode,callback_url,customer_url,delivery_address,delivery_city,delivery_country,delivery_postcode,email,order_reference,user_ip,hmac_fields'
        );

        $everyPay = new Everypay();

        if($this->config->get('everypay_mode') === 'live') {
            $fields['api_username'] = $this->config->get('everypay_api_username');
            $everyPay->init($this->config->get('everypay_api_username'), $this->config->get('everypay_api_secret'));
        }else
        {
            $fields['api_username'] = $this->config->get('everypay_test_api_username');
            $everyPay->init($this->config->get('everypay_test_api_username'), $this->config->get('everypay_test_api_secret'));
        }

        $this->data['checkout_title'] = $this->config->get('everypay_title');// == '' ? '';

        $this->data['form_data'] = $everyPay->getFields($fields, $order['language_code'], true);

        if($this->config->get('everypay_mode') === 'live'){
            $this->data['action'] = 1;
        }else
        {
            $this->data['action'] = 0;
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/everypay.tpl')) {
           $this->template = $this->config->get('config_template') . '/template/payment/everypay.tpl';
        } else {
            $this->template = 'default/template/payment/everypay.tpl';
        }
        $this->render();

    }


    public function process ()
    {

        $this->load->model('checkout/order');

        include_once DIR_APPLICATION . '../system/library/Everypay.php';

        $everyPay = new Everypay();

        if($this->config->get('everypay_mode') === 'live') {
            $everyPay->init($this->config->get('everypay_api_username'), $this->config->get('everypay_api_secret'));
        }else{
            $everyPay->init($this->config->get('everypay_test_api_username'), $this->config->get('everypay_test_api_secret'));
        }

        $response = $this->request->post;

        unset($response['utf8'], $response['_method'], $response['authenticity_token']);

        $status = '';
       
        //if opencart has automatically escaped the json, unescape it for HMAC validation.
        if(isset($response['processing_warnings'])){
            $response['processing_warnings'] = html_entity_decode ($response['processing_warnings']);
        }
        if(isset($response['processing_errors'])){
            $response['processing_errors'] = html_entity_decode ($response['processing_errors']);
        }


        foreach($response as $key => $value)
        {
            $status .= "\n$key => $value";
        }


        $status = $everyPay->verify($response);

        switch ($status)
        {
            case 1:
                if (method_exists($this->model_checkout_order, "addOrderHistory")){
                    $this->model_checkout_order->addOrderHistory($this->request->post['order_reference'], $this->config->get('everypay_order_status_id'), '', true);
                }else{
                    $this->model_checkout_order->confirm($this->request->post['order_reference'], $this->config->get('everypay_order_status_id'), '', true);
                }
                $this->response->redirect($this->url->link('checkout/success'));
                break;
            case 2:
                if (method_exists($this->model_checkout_order, "addOrderHistory")){
                    $this->model_checkout_order->addOrderHistory($this->request->post['order_reference'], 7, '', true);
                }else{
                    $this->model_checkout_order->confirm($this->request->post['order_reference'], 7, '', true);
                }
                $this->response->redirect($this->url->link('checkout/checkout'));
                break;
            case 3:
                if (method_exists($this->model_checkout_order, "addOrderHistory")){
                    $this->model_checkout_order->addOrderHistory($this->request->post['order_reference'], 10, '', true);
                }else{
                     $this->model_checkout_order->confirm($this->request->post['order_reference'], 10, '', true);
                }
                $this->response->redirect($this->url->link('checkout/checkout'));
                break;
            default:
                $this->response->redirect($this->url->link('checkout/checkout'));
        }
    }

}
