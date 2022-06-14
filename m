Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E922F54B39B
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jun 2022 16:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiFNOmN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jun 2022 10:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiFNOmN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jun 2022 10:42:13 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583785F8D
        for <linux-raid@vger.kernel.org>; Tue, 14 Jun 2022 07:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1655217727; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=MBP1Ccejelrb8vraaSqf202Xbue1J789MrO5FXgLC+SwdVn1/eKXJQoGms689M9KnYH0Pnby+RLWQYx8WPQakoAZF8iTuqbMy9eiO2QBrmCEH2v7MEt/j0MNn2CJcbHSxTiMf9WJuUrs60l4kgwo6tudQ0KSqOfLzc+JXjaHl0Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1655217727; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=JuQeUDKbnxbgkcOATw3pW0Hv0k+y8pbepewrpxOG5/0=; 
        b=AYlJJGjtfWcfmgUSIlHTJJiOftbSq4tsvsNEmRTOZM6b5sQbE8NHE5MLuMQWbZ6Uy7oOVPr12n2GnPgrYq525maFUp6WnAzkUZVkvYoscL5EuL987Ck+u+pgABZcOw90oJWAKe0Uc1tya9JHTGn/uaUpsrPv2pda1vR7sASi1hk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [172.30.27.237] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1655217725969115.48651704458598; Tue, 14 Jun 2022 16:42:05 +0200 (CEST)
Message-ID: <50517a73-7eb4-1949-145e-1294a5a9483c@trained-monkey.org>
Date:   Tue, 14 Jun 2022 10:42:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH resend] Fix possible NULL ptr dereferences and memory
 leaks
Content-Language: en-US
To:     Mateusz Grzonka <mateusz.grzonka@intel.com>,
        linux-raid@vger.kernel.org
References: <20220613095934.19042-1-mateusz.grzonka@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220613095934.19042-1-mateusz.grzonka@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/13/22 05:59, Mateusz Grzonka wrote:
> In Assemble there was a NULL check for sra variable,
> which effectively didn't stop the execution in every case.
> That might have resulted in a NULL pointer dereference.
> 
> Also in super-ddf, mu variable was set to NULL for some condition,
> and then immidiately dereferenced.
> Additionally some memory wasn't freed as well.
> 
> Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
> ---
>  Assemble.c  | 7 ++++++-
>  super-ddf.c | 9 +++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)

Applied!

Thanks,
Jes


