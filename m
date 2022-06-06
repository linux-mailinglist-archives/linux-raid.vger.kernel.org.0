Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B0453EA75
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jun 2022 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbiFFPPs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jun 2022 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiFFPPp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jun 2022 11:15:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A30913C09F
        for <linux-raid@vger.kernel.org>; Mon,  6 Jun 2022 08:15:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q21so29616471ejm.1
        for <linux-raid@vger.kernel.org>; Mon, 06 Jun 2022 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=MhwsgjFN/b+Bq7I8URcr4K2rzK+3ccDCxc8rqKwPKVE=;
        b=DMJn2xsLbUgN2cs2RvhSdcue7cOntSiwJIVFwQbf+7TW1FynxJqwoALm/QczfxxYB/
         H683x1zwdoKrh2bVSkj2zVHgHYD4tGyVuIB2zfcIHUvQEwAU+/5L9oe4i4rk09GqAclL
         MFw8+37xV3l8u6DFtY9Yj9EwaC+l0zG3U+5IWfsifHl+9fhHx0QJa1xNfW9YZryt4pkC
         VebBlDS9NoDdarARV/VgMMIcd6MSsQEgE72FkDEtA3kDFwJcBWWN+mp3zQAjT8rnBSRw
         kbDChgOnID1CWAlV7TZeqztAI3uRLoPRB3UwQ/zcmE/H7M3wgPDKve1pfqWsJTFFZ6Ry
         jJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=MhwsgjFN/b+Bq7I8URcr4K2rzK+3ccDCxc8rqKwPKVE=;
        b=h++CpL3pHX4OnYIEnCDgHkmVWVsTG8b1slRs74VMGjR9ER9Q0clJeTxZ2u66LKRsxs
         YEZ3xZE+PwfVAtkzdV7fr3wSUGep1sGr4LtOk6VA3DTQZbioLckSHwJzKfEnhYaWAdAb
         ELMLvYDpI1OQKJnfVQSvcDgJjFfATzADRjv4swNHHkEpBcgERWABsE8UwoTjqrTI0A7G
         qwZYFpI/utKZN5IsqjclQdkNDrxIZRY+QKDV6jITTrNttWLbRM+8n6LJImfcQhx59Ljk
         K6DUauvW3LJHNDiX+VOR7L0+Cc0UNtvOOeuut2j8+0kpdPitrQ6S+Q6wD9ze8QW5iQYs
         HB6A==
X-Gm-Message-State: AOAM533htN9mTQtMVKJWrVunKaT0YvXvk+J11ilVqU5pwZCbqBb/LPXk
        afdmjpfTC4SsYiNtcsnzmyTUzur1mWzvqQ3T2zyWXWNQxPo=
X-Google-Smtp-Source: ABdhPJw4shqLEUF0NQ8UHd9nYp/hvdVhfon4EtK+dHGrcVQdaGUQIPqziFI/DLwqcC9JrH6eDeX2VQHYdkokk9El96k=
X-Received: by 2002:a17:907:1b05:b0:6f0:18d8:7be0 with SMTP id
 mp5-20020a1709071b0500b006f018d87be0mr21635967ejc.561.1654528513690; Mon, 06
 Jun 2022 08:15:13 -0700 (PDT)
MIME-Version: 1.0
Reply-To: shaba@altlinux.org
From:   Alexey Shabalin <a.shabalin@gmail.com>
Date:   Mon, 6 Jun 2022 18:14:48 +0300
Message-ID: <CAEdvWkS6zy0s45+OoTozHim4jEEqbFyypd9S-n0nrHAPL8t0ag@mail.gmail.com>
Subject: error build mdadm with gcc12
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi.
Can not build mdadm with gcc12 and -Werror

mdadm.c: In function 'scan_assemble':
mdadm.c:1815:47: error: the comparison will always evaluate as 'true'
for the address of 'devnm' will never be NULL [-Werror=address]
 1815 |                                 if (e->active && e->devnm &&
      |                                               ^~
In file included from mdadm.c:28:
mdadm.h:622:25: note: 'devnm' declared here
  622 |         char            devnm[32];
      |                         ^~~~~
cc1: all warnings being treated as errors
make: *** [Makefile:193: mdadm.o] Error 1

-- 
Alexey Shabalin
