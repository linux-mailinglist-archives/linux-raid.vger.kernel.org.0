Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82C4D9FD8
	for <lists+linux-raid@lfdr.de>; Tue, 15 Mar 2022 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiCOQVy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Mar 2022 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347846AbiCOQVw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 15 Mar 2022 12:21:52 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D0656C27
        for <linux-raid@vger.kernel.org>; Tue, 15 Mar 2022 09:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1647361223; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=ImW6COpbh023LOAkQxdPV5eC78QMvB+oQ79vkWxLJbInIbuvTVvjETO4AyH/FET1Qh6Anxrob67YcPeUDIoXixUqIA28yL3+o9NO1gxpLylgX4AZCNmoMFBgWA3W7ZJjTD+bynNsmTKvs9R+6Q3UEidon2fHbJ+kBOHXVjjzZQs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1647361223; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=olPkQJUM0oJwngNjp7rJD72UCKZTVKM/DrNNsZr81Wo=; 
        b=WMXhiBp6N0MPJZLlUhafL55+0N6gjn6VU51HpBITRRKvybxoMbwEDFaiOeoCB/fvriuFwh6QlFgjeO4a6VlcMVchlJM7BVE3wC7G1DdkRDUHYf45gD/fPDIEgQ2qZdRelAMXFuOK4P6jwyCu1Sf63aBg8KYDA/hA6o7j/zjhb04=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [172.30.27.237] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1647361220330843.0322169649013; Tue, 15 Mar 2022 17:20:20 +0100 (CET)
Message-ID: <14629f89-741e-61d3-b410-bfee0292174b@trained-monkey.org>
Date:   Tue, 15 Mar 2022 12:20:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Unify error message.
Content-Language: en-US
To:     Lukasz Florczak <lukasz.florczak@linux.intel.com>,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de
References: <20220315083030.58992-1-lukasz.florczak@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220315083030.58992-1-lukasz.florczak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/15/22 04:30, Lukasz Florczak wrote:
> Provide the same error message for the same error that can occur in Grow.c and super-intel.c.
> 
> Signed-off-by: Lukasz Florczak <lukasz.florczak@linux.intel.com>

Applied, thanks

Jes

