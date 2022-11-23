Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23192635ADA
	for <lists+linux-raid@lfdr.de>; Wed, 23 Nov 2022 12:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiKWK6o (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 23 Nov 2022 05:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiKWK6S (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 23 Nov 2022 05:58:18 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0904025D4
        for <linux-raid@vger.kernel.org>; Wed, 23 Nov 2022 02:51:21 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id p1so6128108uak.11
        for <linux-raid@vger.kernel.org>; Wed, 23 Nov 2022 02:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=FBwAkBxTmNDag1/RDsqnfwoC0s+LU+uQntSOMfe3GSCdxg/WdJIaeK3nMORdvGb5zG
         g43tVlbSNj20SK3PP1sGN5hDcKntIEdOpWmXrYe06DuuyhtAeX6FecK/7UmXKe0UQHBx
         fetfvcCS0uzWDSiBWNo7YRrgTkIOGJAYAqdJuBE7y8wI3p4iYajuP5iZrLOEbF8VxYUg
         SxaHLaX8NlQrvDFTPXnqVo9nmS3nlPgclsad7NVd4Q9QUA8ulXUS2GYCY27iucY6lDyX
         N1lTP82dBjTlBl/vAcq4IssvJN848TysRKwqodIBDBTtCi7ITXy6wpb78vjF/pkLbODP
         iwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=JAcqfB16khL4np3QpcmeI3bAj0Jois5gEOXumm6TijIJe4pjTS/L72eot2hFPBooM9
         5gg+blGuiKE5yiEkrVMybag8fNPEpOjm9OTm5b9LOM+X4Z8u5qh/RLacvMjDEcwJA04S
         O/cglhplO69iM7uRG1cevTLx6bcbzCPQNKIxecmPW1vbmIxQX5ZCad8ezgGHo9Qp1shZ
         F/piMWLs6ZpxwZkGYakBMjhjH9dO83YNW3/Pq6Ow7Ao4d9sXAnsnN+eHeFSim1ZGc4lI
         bXbnR4+e+6UFaI+i5PyMsoVMnyhna3aMEo614nNIebuRUg8Mjx5Tw4hBRtY+9OLFMVAE
         ALsg==
X-Gm-Message-State: ANoB5pk7/TERLCZRlNVl+z54CjUomw3SS6VkRinwtCE83tOwBIOIsp1+
        Q9Up8oSHPwSROveCV7G3lyXikATK7CNbSCRyVME=
X-Google-Smtp-Source: AA0mqf7SzwCL2QdxUtLbvI6h7Q3/yt3wg6QF8l1/BjQowEdvn1kE1gyFSlYS7kIrtOXYiNjinIb9y7Ok3IcvISBX4a4=
X-Received: by 2002:ab0:b89:0:b0:40c:826c:d49b with SMTP id
 c9-20020ab00b89000000b0040c826cd49bmr4941783uak.74.1669200680020; Wed, 23 Nov
 2022 02:51:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:612c:15a2:b0:2d3:aa6c:c9f7 with HTTP; Wed, 23 Nov 2022
 02:51:19 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <sb8766198@gmail.com>
Date:   Wed, 23 Nov 2022 02:51:19 -0800
Message-ID: <CALhHHanMSG=7JPh52j7uWAnn7Ns0i7i2zxQby-NL9AuQD7M1=Q@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:92c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sb8766198[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sb8766198[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [subik7633[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
