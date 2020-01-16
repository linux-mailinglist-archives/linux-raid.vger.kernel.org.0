Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A999F13F4EA
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jan 2020 19:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgAPSwx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jan 2020 13:52:53 -0500
Received: from sender21-op-o12.zoho.eu ([185.172.199.226]:17333 "EHLO
        sender21-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgAPSwv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jan 2020 13:52:51 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 13:52:50 EST
Received: from [172.30.220.41] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1579200759726492.7150432144971; Thu, 16 Jan 2020 19:52:39 +0100 (CET)
Subject: Re: [mdadm PATCH 1/1] mdcheck service can't start succesfully because
 of syntax error
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid@vger.kernel.org
References: <1576651581-5135-1-git-send-email-xni@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <a8e72def-0cfa-9574-2709-c6189e1fbcc8@trained-monkey.org>
Date:   Thu, 16 Jan 2020 13:52:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1576651581-5135-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/18/19 1:46 AM, Xiao Ni wrote:
> It reports error when starting mdcheck_start and mdcheck_continue service.
> Invalid environment assignment, ignoring: MDADM_CHECK_DURATION="6 hours"
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>

Applied!

Thanks,
Jes



