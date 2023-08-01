Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828A076AE5D
	for <lists+linux-raid@lfdr.de>; Tue,  1 Aug 2023 11:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjHAJiN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Aug 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHAJho (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Aug 2023 05:37:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE98A212D
        for <linux-raid@vger.kernel.org>; Tue,  1 Aug 2023 02:36:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso51139935e9.0
        for <linux-raid@vger.kernel.org>; Tue, 01 Aug 2023 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690882564; x=1691487364;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANXExHiurpsLW1+AnLl79UdLdXb9JEMrjqkSigWkyLQ=;
        b=ZQW246AZoFvB3hhurfyRQ76vAF+FnJzNpWaRZmGoeeVjR4CVn+Xeg8kzNJyKVJuV8n
         96iq1raw/QJ2h4unBekQkBeQ1prQ6tRR07c/jKThzzFscy62mukf3mdt2ya9f/a7bH8G
         31XF7e+QS0axG/fHFpQTCRQiMSRrJNwfYVi8iQZlT9Dd5OOXN0IebjJGSWVlNCUNUnbl
         E2HckSUpAt4UjtUGRUc3QtGRBx5jcl+0YHdgSWZHpjZqaupg3OiZjdTmA4NqyRkEdFx9
         2P3ouA4Z888BXZnuoc15BWzK+LzAekxznwQiijVs+HUXU5LTglA0tu2qtD9C7gANQwoD
         d3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882564; x=1691487364;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANXExHiurpsLW1+AnLl79UdLdXb9JEMrjqkSigWkyLQ=;
        b=Yue8Kg7It/JZnijskmvcEaV8nzfE3ZSVKhuXNYfbypDrPvCET/aFjr0TtwrbnrJ+Y6
         RxD9tp9BwjFFIjOqfapW1fZwhrwNYSjyMdBt6kXXdvtOiZwDprtPid1ch/bHW2NvOPe6
         f+Jn+zAQe5+BF9LAs4G8MTtEnfO6JdnKRohxgM4lyS8gw1D7TFD6osAlMHHWNy7DGfzv
         Q6OJnt4JSu5Z2hsWLNu4J/N9Lpe6JvQEeXR62bXKyBBF+1Cx8hzXrn7l+JxC+v4Z8+0o
         cnYcGK1xkiJRB1S6GOaoI5W0sMv9lyUPa5t1+6/Iwrj8eF5lHJt28WF0RFNADBad3+Gc
         Uxhw==
X-Gm-Message-State: ABy/qLakupEOnZdN2SIkpNPf0Mkbwu6WBSGgkZ/q13FLJiNLD9wbk1Dq
        OFJh7UfEkkPVPFU3HTTmr7l6vAFz8M3ugg==
X-Google-Smtp-Source: APBJJlGlDITblt/zfqLglniCBl5pLym1fNSvtvAhnHQ+7ij4J+udVl1ji+vNZ1R2azEHfDmlxDdKhg==
X-Received: by 2002:a1c:770c:0:b0:3fb:fea1:affa with SMTP id t12-20020a1c770c000000b003fbfea1affamr1936558wmi.37.1690882564067;
        Tue, 01 Aug 2023 02:36:04 -0700 (PDT)
Received: from [192.168.1.102] ([91.239.206.92])
        by smtp.gmail.com with ESMTPSA id k17-20020a7bc411000000b003fe17901fcdsm8477610wmi.32.2023.08.01.02.36.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Aug 2023 02:36:03 -0700 (PDT)
Message-ID: <64c8d203.7b0a0220.a701d.3bbb@mx.google.com>
From:   World Health Empowerment Organization Group 
        <petricaluchian839@gmail.com>
X-Google-Original-From: World Health Empowerment Organization Group
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: We have a Job opportunity for you in your country;
To:     Recipients <World@vger.kernel.org>
Date:   Tue, 01 Aug 2023 16:35:54 +0700
Reply-To: drjeromewalcott@gmail.com
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Greetings! Sir /Madam.
                   =

We are writing this email to you from (World Health Organization Empowermen=
t Group) to inform you that we have a Job opportunity for you in your count=
ry, if you receive this message, send your CV or your information, Your Ful=
l Name, Your Address, Your Occupation, to (Dr.Jerome) via this email addres=
s: drjeromewalcott@gmail.com  For more information about the Job. The Job c=
annot stop your business or the work you are doing already. =


We know that this Message may come as a surprise to you.

Best Regards
Dr.Jerome =

Office Email:drjeromewalcott@gmail.com
Office  WhatsApp Number: +447405575102. =

Office Contact Number: +1-7712204594
