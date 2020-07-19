Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDA225205
	for <lists+linux-raid@lfdr.de>; Sun, 19 Jul 2020 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgGSNrP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jul 2020 09:47:15 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:49453 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgGSNrO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 19 Jul 2020 09:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595166431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKRczeD0LpzABMy5/IWupgnQnmbdj5NnaEjL+6dunpc=;
        b=g9ENJTg8D2NjkiP2++n7nkUe++nslEMzoLz+n6ymhyfnBjn3B7U35MkguV/kut3NaVTobI
        JUSYRVjXl0UDNG239hah8O9KFxN4pVqbH9I/yvzamDh35MOPLkLIjDWfcEksOyI1KB8FEd
        ZJx3P5MqNUg84vRO2byswYtKbBhCH14=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-RbGx4QXSMTGM03bRQ3upXQ-2; Sun, 19 Jul 2020 15:47:10 +0200
X-MC-Unique: RbGx4QXSMTGM03bRQ3upXQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2BVmrbT7Vlr3XjwiLTazZwcHWG2urWaweVMuN8bbUnMw7ecJqXx55ZLMQyb+I8ARMn3woXGv63PQki2DNibWeTOuNGHW2qr57WDaz1R7KqaQhGs9FvseUZv1xnfAeKnovKf69UKIZ5x0+PhB9E+Hl1wrpcIGBPAIGXsulberO4eoxLNpU5x2z/pYHMaF4nCoxLcFSXsSh3PQ46dOAADIvSkwI3rtA8yfaqS8y16o37i/5kYJjwBHVEf0f44e6pbdLJg4yw4KHr8oKjuQdr9TfW4ZbzkBvR/Q+aUdl9iEwhquJK0cywYXrc7ezJVT3hz/neWRluVsBiU9FKVNF204g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKRczeD0LpzABMy5/IWupgnQnmbdj5NnaEjL+6dunpc=;
 b=oWOLNo2+Z8jr+pEwXYuwXF/DohgyqM4cJB0J74Z9Z5ocmpfmIzTmDCyOrjg/h5FmLGp1XVkN4cx9+9oooKJc87glU3WIQ3MQuvgS/U5WVXLbLMjk3lm02WjcQOfC4WVc1iSNEuMw4/6q8u4m9Y6QdIcXI0/AAc2HK5wKDAeoy1NahgR43A4t01g5dzOCOQGHLJw6HX8TE4f91+YKJNIH47KvP7V2IUSJ7TWvyo55VgjT/jM0lKCj1pEeQkM5D88qrLCEpocmfJN3l8q/LrGPkBBFHwblwoEGwUkCwf9ZkDQDyFeLnPUYYtmOOQr6ebQSlXwQ7w1NxrTqabmp5oExFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB6PR04MB3093.eurprd04.prod.outlook.com (2603:10a6:6:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Sun, 19 Jul 2020 13:47:06 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.023; Sun, 19 Jul 2020
 13:47:06 +0000
Subject: Re: [PATCH v4 0/2] md_cluster: bugs fix
To:     linux-raid@vger.kernel.org
Cc:     neilb@suse.com, jes@trained-monkey.org, Song Liu <song@kernel.org>
References: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <ad5db04d-f5e0-4265-763e-b1f12b45e8c4@suse.com>
Date:   Sun, 19 Jul 2020 21:46:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0214.apcprd02.prod.outlook.com
 (2603:1096:201:20::26) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR02CA0214.apcprd02.prod.outlook.com (2603:1096:201:20::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Sun, 19 Jul 2020 13:47:04 +0000
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4def055-91f6-4a44-2f0d-08d82bea39d0
X-MS-TrafficTypeDiagnostic: DB6PR04MB3093:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB3093FA087DBCF94802800259977A0@DB6PR04MB3093.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVHeVYB+Vmbz5SvtkI5nwyK1BJWHIK1MlLhxkP4n9ltsbznCufpqdir5rOmRQ3X3oJP7zK3gjxq1fFLaLyG3jKCO/PTI0J0wNA0DBDS4EXNfzNXjwlqflxsIji5woQtde1HTLaImBrZItO5DHui3E6GX7mB2lIKacSFj4KZ1P7TINyUt492fQhXoc3vyXc/bYMC3vJkDWBycZy0pvqm7exYTqvZsTmzae7BxT0NiomGEbduTG5NhshH3GmDKHuRS+aAyCkM+Ju5sOzCqNSUnNRFUTbL56qsWybT+N8610QKQIqd9BJqsqiWS4GYZGqH0ez14JvGv7lVULH/pEoFtVzGiogtGsjLf85SgXdpxKfFMKiNZTHXgG26/Jb4y+wsbRbCYWjdH7zJgZ/RFGk13Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(26005)(16526019)(66476007)(4326008)(6916009)(6486002)(66556008)(956004)(6512007)(8936002)(186003)(4744005)(2616005)(66946007)(8886007)(478600001)(31696002)(6666004)(86362001)(2906002)(83380400001)(8676002)(52116002)(36756003)(5660300002)(6506007)(53546011)(316002)(31686004)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: inidJQmywenPUqK5nGQuORLxUnaMd64AlryEcbvt0F8eulBPkJkBfoEVTCWsPTX96yMkWlDPAoZwoEN4xrbBuijPZ7VkT0BDm9gda3VYPLgnrYqfh8mPzmt0OJDPmMjsyCwE6rgaev+gZJoa/lytLG8k2jkyLJ6RfZVoX885p04ct+Kg4CnWSXa1bpiV1EPakd7kF9LyK6jhJBcUjHmLxf5XCt29WmpIyS3cs4yzy5Ro4zCoQXsJGcA4TjRMJCNFIO9o7vQdKnHJhn09hhPhq5HVVRuwM29V4YihoQnuZKk0qb7/3qbKfWwQJ8q7b2gDPK8wHl93uRntsILJ7o5XOyeByLGfFYLbzjP3fQnX7CFBWggdNGHkl67gpX1bjBR6TOWLvJMERrvbO8u4pD+FwgWhihe970iL2ThbY+aZQcm1VPiW+T1gp4XveSQmQGein36iQjVqQwpdABAdyV8uVC4g7muDAQZIn3y/8vNbwfM=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4def055-91f6-4a44-2f0d-08d82bea39d0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 13:47:06.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjdXjn5O4dNiMDMPo9xwRsONwhmQiMPEAhE5UuWRTAnlo/qay4AtvAfYN12CZNRAbnjjZSYpyGGibChMIpFl1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3093
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Very sorry, I mistakenly added Jes, CC Song in this mail.

Jes, please ignore these patches, sorry for CC you.

On 7/19/20 7:08 PM, Zhao Heming wrote:
> v4:
> - add new patch 'fix rmmod issue when md_cluster convert bitmap to none'
> - add cover leter
> - modify both patches comments.
> 
> v3:
> - add restoring path for error case
> - modify comments
> 
> v2:
> - change setting path from location_store to md_setup_cluster
> - add restoring path
> 
> v1:
> - create: fix safemode_delay value when converting to clustered bitmap
> 
> Zhao Heming (2):
>    md-cluster: fix safemode_delay value when converting to clustered
>      bitmap
>    md-cluster: fix rmmod issue when md_cluster convert bitmap to none
> 
>   drivers/md/md.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 

