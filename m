Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9024D1EFC48
	for <lists+linux-raid@lfdr.de>; Fri,  5 Jun 2020 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFEPO2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 5 Jun 2020 11:14:28 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17153 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgFEPO1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 5 Jun 2020 11:14:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591370064; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=KK5vtgtOhvdMwcXXiiBeu7nL1+Ck1VORK/MKDchEIxl9kwr0C9LzCfAAumwerP0ozLHu3fQL/pgUMliKPkqvhTISZq+mDSVMnyG+AjKFI4l15G4I3eZWw9cPDjAgp20StOzQ2VwhrIMytgPPC4ZHY7D6DDxeirm68321oijlKQ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1591370064; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+gQg4Xun1fPxJkkKqVH7oAwYkRLPcKf3/kU28M/1WD8=; 
        b=MLNNVtJ4WyGIknJQnfR7w0FIM7a5/doiid6TIYN3rBXXyCVXQPCfgtiERzzl7w1n0IBsKjlq7DlkzUXc6+wIaVZajktWI3loYv+uJMIbcQqo1kjOpq9ly9LJ/G2a+nnNIKqWekf0+wEeOdivrnkm9K7rO85hUFbnze+2Z7aZXZE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.108.78.247] (163.114.132.6 [163.114.132.6]) by mx.zoho.eu
        with SMTPS id 1591370062106872.9827421668028; Fri, 5 Jun 2020 17:14:22 +0200 (CEST)
Subject: Re: [PATCH,v2] Block overwriting existing links while manual assembly
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
References: <20200529063136.8177-1-kinga.tanska@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <e04a6c51-9941-e65a-2170-277f367d8436@trained-monkey.org>
Date:   Fri, 5 Jun 2020 11:14:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529063136.8177-1-kinga.tanska@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/29/20 2:31 AM, Kinga Tanska wrote:
> Manual assembly with existing link caused overwriting
> this link. Add checking link and block this situation.
> 
> Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
> ---
>  Assemble.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied!

Thanks,
Jes

