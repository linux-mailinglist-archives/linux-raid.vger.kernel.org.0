Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A995BAFD5
	for <lists+linux-raid@lfdr.de>; Fri, 16 Sep 2022 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiIPPEm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Sep 2022 11:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiIPPEj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Sep 2022 11:04:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1634D13D5B
        for <linux-raid@vger.kernel.org>; Fri, 16 Sep 2022 08:04:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C390733893;
        Fri, 16 Sep 2022 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663340674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IOJssIcs74dnimTKZ5xRynZb5kC3pP1fwa4Wqg2/D4=;
        b=hpx/VmQFIfdASIjLEprdrhI0SEfkyU7DeuqeyjmI6ZThi5cAvQNbKfYrdyt6ttFHGv0dRn
        72gVvm7KTBeqEAZqu3UP8Pt8X8TZW+BCn4oe3pTD+3dto7Zkzgn2do/DmuwMYBgbkpB1t2
        NAGvSi9zXCFj0wO3yYQ6r8gEI21NJBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663340674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IOJssIcs74dnimTKZ5xRynZb5kC3pP1fwa4Wqg2/D4=;
        b=zugIBFnqx4zqUd92LlJqLFXd7wIhzfQMrEE/PpDKoLBMs0ZRe2lWNCG8L5qQ/6z4Ym11Lu
        +8SR2Rd2LWLJ1/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8686D1346B;
        Fri, 16 Sep 2022 15:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Ae9EYGQJGNuZwAAMHmgww
        (envelope-from <colyli@suse.de>); Fri, 16 Sep 2022 15:04:33 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 2/2] ReadMe: fix command-line help
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20220909135034.14397-3-mariusz.tkaczyk@linux.intel.com>
Date:   Fri, 16 Sep 2022 23:04:32 +0800
Cc:     Jes Sorensen <jes@trained-monkey.org>, felix.lechner@lease-up.com,
        linux-raid@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB255C3A-82D9-4B57-BE42-D7EC7AF25AA9@suse.de>
References: <20220909135034.14397-1-mariusz.tkaczyk@linux.intel.com>
 <20220909135034.14397-3-mariusz.tkaczyk@linux.intel.com>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> 2022=E5=B9=B49=E6=9C=889=E6=97=A5 21:50=EF=BC=8CMariusz Tkaczyk =
<mariusz.tkaczyk@linux.intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Make command-line help consistent with manual page.
> Copied from Debian.
>=20
> Cc: Felix Lechner <felix.lechner@lease-up.com>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li


> ---
> ReadMe.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ReadMe.c b/ReadMe.c
> index 7f94847..50a5e36 100644
> --- a/ReadMe.c
> +++ b/ReadMe.c
> @@ -477,7 +477,7 @@ char Help_assemble[] =3D
> ;
>=20
> char Help_manage[] =3D
> -"Usage: mdadm arraydevice options component devices...\n"
> +"Usage: mdadm [mode] arraydevice [options] <component devices...>\n"
> "\n"
> "This usage is for managing the component devices within an array.\n"
> "The --manage option is not needed and is assumed if the first =
argument\n"
> --=20
> 2.26.2
>=20

